import BagbutikSpecDecoder
import Foundation
import Stencil
import StencilSwiftKit
import SwiftFormat

/// A renderer which renders object schemas
public class ObjectSchemaRenderer {
    /**
     Render a object schema

     - Parameters:
        - objectSchema: The object schema to render
     - Returns: The rendered object schema
     */
    public func render(objectSchema: ObjectSchema) throws -> String {
        let context = objectContext(for: objectSchema, in: environment)
        let rendered = try environment.renderTemplate(name: "objectTemplate", context: context)
        return try SwiftFormat.format(rendered)
    }

    private static let constantTemplate = """
    public var {{ id|escapeReservedKeywords }}: String { "{{ value }}" }
    """
    private static let objectTemplate = #"""
    {% if summary %}/**
      {{ summary }}

      Full documentation:
      <{{ url }}>{% if discussion %}

      {{ discussion }}{% endif %}
    */
    {% elif summary %}/// {{ summary }}
    {% endif %}public struct {{ name|upperFirstLetter }}: Codable{% if isRequest %}, RequestBody{% endif %}{% if isPagedResponse %}, PagedResponse{% endif %} {
        {% if pagedDataSchemaRef %}public typealias Data = {{ pagedDataSchemaRef }}{%
        endif %}{% for property in properties %}
        {% if property.documentation %}/// {{ property.documentation }}
        {% else %}{%
        endif %}{{ property.rendered }}{%
        endfor %}{%
        if hasAttributes %}
        /// {{ attributesDocumentation }}
        public let attributes: Attributes{% if attributesOptional %}?{% endif %}{% endif %}{%
        if hasRelationships %}
        /// {{ relationshipsDocumentation }}
        public let relationships: Relationships{% if relationshipsOptional %}?{% endif %}{% endif %}

        {% if deprecatedPublicInitParameterList %}
        @available(*, deprecated, message: "This uses a property Apple has marked as deprecated.")
        public init({{ deprecatedPublicInitParameterList }}) {
            {% for propertyName in deprecatedPublicInitPropertyNames %}
            self.{{ propertyName.safeName }} = {{ propertyName.safeName }}{%
            endfor %}
        }
        {% endif %}public init({{ publicInitParameterList }}) {
            {% for propertyName in publicInitPropertyNames %}
            self.{{ propertyName.safeName }} = {{ propertyName.safeName }}{%
            endfor %}
        }
        {% if needsCustomCoding %}
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self){%
            for decodableProperty in decodableProperties %}{%
            if decodableProperty.optional %}
            {{ decodableProperty.name.safeName }} = try container.decodeIfPresent({{ decodableProperty.type }}.self, forKey: .{{ decodableProperty.name.safeName }}){%
            else %}
            {{ decodableProperty.name.safeName }} = try container.decode({{ decodableProperty.type }}.self, forKey: .{{ decodableProperty.name.safeName }}){%
            endif %}{% endfor %}
            {% if hasTypeConstant %} if try container.decode(String.self, forKey: .type) != type {
                throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Not matching \(type)")
            }{% endif %}
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self){%
            for encodableProperty in encodableProperties %}{%
            if encodableProperty.optional %}
            try container.encodeIfPresent({{ encodableProperty.name.safeName }}, forKey: .{{ encodableProperty.name.safeName }}){%
            else %}
            try container.encode({{ encodableProperty.name.safeName }}, forKey: .{{ encodableProperty.name.safeName }}){%
            endif %}{% endfor %}
        }

        private enum CodingKeys: String, CodingKey {
            {% for codingKey in codingKeys %}
            case {{ codingKey.safeName }} = "{{ codingKey.idealName }}"{%
            endfor %}
        }
        {% endif %}
        {% if subSchemas.count > 0 %}
            {% for subSchema in subSchemas %}

                {{ subSchema|indent }}
            {% endfor %}
        {% endif %}
    }
    """#
    private let environment = Environment(loader: DictionaryLoader(templates: [
        "constantTemplate": constantTemplate,
        "objectTemplate": objectTemplate
    ]), extensions: StencilSwiftKit.stencilSwiftEnvironment().extensions)

    private func objectContext(for objectSchema: ObjectSchema, in environment: Environment) -> [String: Any] {
        let subSchemas = objectSchema.subSchemas
        let sortedProperties = objectSchema.properties.sorted { $0.key < $1.key }
        let hasAttributes = objectSchema.attributesSchema != nil
        let hasRelationships = objectSchema.relationshipsSchema != nil
        let attributesOptional = !objectSchema.requiredProperties.contains("attributes")
        let relationshipsOptional = !objectSchema.requiredProperties.contains("relationships")
        var initParameters = sortedProperties.filter { !$0.value.type.isConstant }
        var codingKeys = sortedProperties.map { PropertyName(idealName: $0.key) }
        var encodableProperties = sortedProperties.map {
            CodableProperty(name: PropertyName(idealName: $0.key),
                            type: $0.value.type.description,
                            optional: !objectSchema.requiredProperties.contains($0.key) && $0.key != "type")
        }

        if hasAttributes {
            let name = "attributes"
            let type = "Attributes"
            initParameters.append((key: name, value: Property(type: .schemaRef(type))))
            codingKeys.append(PropertyName(idealName: name))
            encodableProperties.append(CodableProperty(name: PropertyName(idealName: name), type: type, optional: attributesOptional))
        }
        if hasRelationships {
            let name = "relationships"
            let type = "Relationships"
            initParameters.append((key: name, value: Property(type: .schemaRef(type))))
            codingKeys.append(PropertyName(idealName: name))
            encodableProperties.append(CodableProperty(name: PropertyName(idealName: name), type: type, optional: relationshipsOptional))
        }
        let decodableProperties = encodableProperties.filter { $0.name.idealName != "type" }
        let attributesDocumentation = objectSchema.documentation?.properties["attributes"] ?? ""
        let relationshipsDocumentation = objectSchema.documentation?.properties["relationships"] ?? ""
        var deprecatedPublicInitParameterList = ""
        if initParameters.contains(where: \.value.deprecated) {
            deprecatedPublicInitParameterList = createParameterList(from: initParameters, requiredProperties: objectSchema.requiredProperties)
        }
        let publicInitParameterList = createParameterList(from: initParameters.filter { !$0.value.deprecated }, requiredProperties: objectSchema.requiredProperties)
        let isPagedResponse = objectSchema.properties["links"]?.type == .schemaRef("PagedDocumentLinks")
        var pagedDataSchemaRef = ""
        if case .arrayOfSchemaRef(let schemaRef) = objectSchema.properties["data"]?.type {
            pagedDataSchemaRef = schemaRef
        }
        let hasTypeConstant = sortedProperties.contains(where: { $0.key == "type" && $0.value.type.isConstant })
        return ["name": objectSchema.name,
                "summary": objectSchema.documentation?.summary ?? "",
                "url": objectSchema.url,
                "discussion": objectSchema.documentation?.discussion ?? "",
                "isRequest": objectSchema.name.hasSuffix("Request"),
                "isPagedResponse": isPagedResponse,
                "pagedDataSchemaRef": pagedDataSchemaRef,
                "properties": sortedProperties.map { property -> RenderProperty in
                    let rendered: String
                    switch property.value.type {
                    case .constant(let value):
                        rendered = try! environment.renderTemplate(name: "constantTemplate", context: ["id": property.key, "value": value])
                    default:
                        rendered = try! PropertyRenderer().render(id: PropertyName(idealName: property.key).safeName,
                                                                  type: property.value.type.description,
                                                                  optional: !objectSchema.requiredProperties.contains(property.key),
                                                                  isSimpleType: property.value.type.isSimple,
                                                                  deprecated: property.value.deprecated)
                    }
                    let propertyDocumentation = objectSchema.documentation?.properties[property.key]
                    return RenderProperty(rendered: rendered, documentation: propertyDocumentation, deprecated: property.value.deprecated)
                },
                "deprecatedPublicInitParameterList": deprecatedPublicInitParameterList,
                "deprecatedPublicInitPropertyNames": initParameters.map { PropertyName(idealName: $0.key) },
                "publicInitParameterList": publicInitParameterList,
                "publicInitPropertyNames": initParameters.filter { !$0.value.deprecated }.map { PropertyName(idealName: $0.key) },
                "needsCustomCoding": hasTypeConstant || sortedProperties.contains(where: { PropertyName(idealName: $0.key).hasDifferentSafeName }),
                "hasTypeConstant": hasTypeConstant,
                "codingKeys": codingKeys,
                "encodableProperties": encodableProperties,
                "decodableProperties": decodableProperties,
                "hasAttributes": hasAttributes,
                "attributesDocumentation": attributesDocumentation,
                "attributesOptional": attributesOptional,
                "hasRelationships": hasRelationships,
                "relationshipsDocumentation": relationshipsDocumentation,
                "relationshipsOptional": relationshipsOptional,
                "subSchemas": subSchemas.map { subSchema -> String in
                    switch subSchema {
                    case .objectSchema(let objectSchema):
                        return try! render(objectSchema: objectSchema)
                    case .enumSchema(let enumSchema):
                        return try! EnumSchemaRenderer().render(enumSchema: enumSchema)
                    case .oneOf(let name, let oneOfSchema):
                        return try! OneOfSchemaRenderer().render(name: name, oneOfSchema: oneOfSchema)
                    case .attributes(let objectSchema):
                        return try! render(objectSchema: objectSchema)
                    case .relationships(let objectSchema):
                        return try! render(objectSchema: objectSchema)
                    }

                }]
    }

    private func createParameterList(from parameters: [Dictionary<String, Property>.Element], requiredProperties: [String]) -> String {
        parameters.map {
            let propertyName = PropertyName(idealName: $0.key)
            var parameter = "\(propertyName.idealName)"
            if propertyName.hasDifferentSafeName {
                parameter += " \(propertyName.safeName)"
            }
            parameter += ": \($0.value.type.description.capitalizingFirstLetter())"
            guard !requiredProperties.contains($0.key) else { return parameter }
            return "\(parameter)? = nil"
        }.joined(separator: ", ")
    }

    private struct RenderProperty {
        let rendered: String
        let documentation: String?
        let deprecated: Bool
    }

    private struct PropertyName {
        let idealName: String
        let safeName: String
        var hasDifferentSafeName: Bool { idealName != safeName }

        init(idealName: String) {
            self.idealName = idealName
            safeName = idealName == "self" ? "itself" : idealName
        }
    }

    private struct CodableProperty {
        let name: PropertyName
        let type: String
        let optional: Bool
    }
}
