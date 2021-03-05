//
//  Response.swift
//  Pryaniky
//
//  Created by Kirill Magerya on 05.03.2021.
//

struct Response: Codable {
    let data: [Objects]
    let view: [ContentType]
}

// MARK: - Datum
struct Objects: Codable {
    let name: ContentType
    let data: ObjectData
}

// MARK: - DataClass
struct ObjectData: Codable {
    let text: String?
    let url: String?
    let selectedID: Int?
    let variants: [Variant]?
    
    enum CodingKeys: String, CodingKey {
        case text, url
        case selectedID = "selectedId"
        case variants
    }
}

// MARK: - Variant
struct Variant: Codable {
    let id: Int
    let text: String
}

enum ContentType: String, Codable {
    case hz, picture, selector
}
