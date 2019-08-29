//
//  ServiceResponse.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import RealmSwift

class ServiceResponse: Object, Decodable {
    @objc dynamic var totalHits: Int = 0
    @objc dynamic var total: Int = 0
    var hits = List<Image>()
    
    private enum CodingKeys: String, CodingKey {
        case totalHits
        case total
        case hits
    }
    
    override static func primaryKey() -> String? {
        return "totalHits"
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalHits = try container.decode(Int.self, forKey: .totalHits)
        self.total = try container.decode(Int.self, forKey: .total)
        let decodeHits = try container.decodeIfPresent([Image].self, forKey: .hits) ?? [Image()]
        hits.append(objectsIn: decodeHits)
    }
}
