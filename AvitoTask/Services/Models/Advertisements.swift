//
//  Advertisements.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

struct Advertisements: Codable {
    let advertisements: [Advertisement]
}

struct Advertisement: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case image = "image_url"
        case createdAt = "created_date"
    }
}
