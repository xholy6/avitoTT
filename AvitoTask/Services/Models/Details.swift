//
//  Details.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

struct Details: Codable {
    let id: String
    let title: String
    let price: String
    let location: String
    let image: String
    let createdAt: String
    let description: String
    let email: String
    let phoneNumber: String
    let address: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location, description,
            email, address
        case image = "image_url"
        case createdAt = "created_date"
        case phoneNumber = "phone_number"
    }
}
