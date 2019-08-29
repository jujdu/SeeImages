//
//  PageCounter.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

struct PageCounter {

    static var currentPage: Int = 1
    let maxPages: Int = 26

    static var hasMorePages: Bool {
        return currentPage < 26
    }

    static var nextPage: Int {
        return hasMorePages ? PageCounter.currentPage + 1: PageCounter.currentPage
    }
}
