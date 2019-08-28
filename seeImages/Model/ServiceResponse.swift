//
//  ServiceResponse.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

struct ServiceResponse: Codable {
    let totalHits: Int //добавлял чтобы считать колличество страниц, но на сервисе ограничение на 26 страниц
    let hits: [Image]
    let total: Int //
}
