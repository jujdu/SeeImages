//
//  RecordingsResult.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

struct RecordingsResult {
    let recordings: [Image]?
    let error: Error?
    let currentPage: Int
    let maxPages: Int = 26
    
    var hasMorePages: Bool {
        return currentPage < maxPages
    }
    
    var nextPage: Int {
        return hasMorePages ? currentPage + 1: currentPage
    }
}
