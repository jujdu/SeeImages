//
//  Constants.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import UIKit

let URL_BASE = "https://pixabay.com/api/"
let API_KEY = "13444563-94c316606a96f9ea0c34b1829"

typealias ServiceResponseCompletion = (RecordingsResult?) -> ()
//typealias DetailFilmResponseCompletion = (DetailFilm?) -> ()

struct XibNames {
    static let HomeImageCell = "HomeImageCell"
    static let DetailImageCell = "DetailImageCell"
}

struct Identifiers {
    static let HomeImageCell = "HomeImageCell"
    static let DetailImageCell = "DetailImageCell"
}

struct Segues {
    static let ToDetailImageVC = "ToDetailImageVC"
}

struct AppImages {
    static let Placeholder = "placeholder"
}
