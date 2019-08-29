//
//  StorageManager.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveImages(_ image: List<Image>) {
        try! realm.write {
            realm.add(image, update: .modified)
        }
    }
    
    static func saveDowloadingDate(_ image: Image) {
        try! realm.write {
            image.date = Date()
        }
    }

}
