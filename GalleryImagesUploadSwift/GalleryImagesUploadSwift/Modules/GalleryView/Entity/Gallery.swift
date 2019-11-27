//
//	Gallery.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Gallery : Codable {

	let nextCursor : String?
	let resources : [GalleryResource]?


	enum CodingKeys: String, CodingKey {
		case nextCursor = "next_cursor"
		case resources = "resources"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		nextCursor = try values.decodeIfPresent(String.self, forKey: .nextCursor)
		resources = try values.decodeIfPresent([GalleryResource].self, forKey: .resources)
	}
}


struct GalleryResource : Codable {

    let bytes : Int?
    let createdAt : String?
    let format : String?
    let height : Int?
    let publicId : String?
    let resourceType : String?
    let secureUrl : String?
    let type : String?
    let url : String?
    let version : Int?
    let width : Int?


    enum CodingKeys: String, CodingKey {
        case bytes = "bytes"
        case createdAt = "created_at"
        case format = "format"
        case height = "height"
        case publicId = "public_id"
        case resourceType = "resource_type"
        case secureUrl = "secure_url"
        case type = "type"
        case url = "url"
        case version = "version"
        case width = "width"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bytes = try values.decodeIfPresent(Int.self, forKey: .bytes)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        format = try values.decodeIfPresent(String.self, forKey: .format)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        publicId = try values.decodeIfPresent(String.self, forKey: .publicId)
        resourceType = try values.decodeIfPresent(String.self, forKey: .resourceType)
        secureUrl = try values.decodeIfPresent(String.self, forKey: .secureUrl)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        version = try values.decodeIfPresent(Int.self, forKey: .version)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
    }


}
