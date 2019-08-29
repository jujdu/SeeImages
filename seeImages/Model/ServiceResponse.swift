//
//  ServiceResponse.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import RealmSwift

class ServiceResponse: Object, Decodable {
    var hits = List<Hit>()
    
    private enum CodingKeys: String, CodingKey {
        case hits
    }
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let decodeHits = try container.decodeIfPresent([Hit].self, forKey: .hits) ?? [Hit()]
        hits.append(objectsIn: decodeHits)
    }
}
