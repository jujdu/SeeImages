//
//  Images.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
import RealmSwift

class Image: Object, Decodable {
    @objc dynamic var  id: Int = 1
    @objc dynamic var  previewURL: String = ""
    @objc dynamic var  largeImageURL: String = ""
    @objc dynamic var  imageWidth: Int = 0
    @objc dynamic var  imageHeight: Int = 0
    @objc dynamic var  imageSize: Int = 0
    @objc dynamic var  tags: String = ""
    @objc dynamic var  date: Date?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case previewURL
        case largeImageURL
        case imageWidth
        case imageHeight
        case imageSize
        case tags
        case date
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }

//    public required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.previewURL = try container.decode(String.self, forKey: .previewURL)
//        self.largeImageURL = try container.decode(String.self, forKey: .largeImageURL)
//        self.imageWidth = try container.decode(Int.self, forKey: .imageWidth)
//        self.imageHeight = try container.decode(Int.self, forKey: .imageHeight)
//        self.imageSize = try container.decode(Int.self, forKey: .imageSize)
//        self.tags = try container.decode(String.self, forKey: .tags)
//        let decodeHits = try container.decodeIfPresent([Image].self, forKey: .hits) ?? [Image()]
//        hits.append(objectsIn: decodeHits)
//    }
}
