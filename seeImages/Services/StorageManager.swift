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
    
    static let shared = StorageManager()
    
    func saveImages(_ hits: List<Hit>) {
        try! realm.write {
            realm.add(hits, update: .modified)
        }
    }
    
    func saveDowloadingDate(_ hit: Hit) {
        try! realm.write {
            hit.date = Date()
        }
    }

}
