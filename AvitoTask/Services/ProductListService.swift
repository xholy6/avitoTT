//
//  ProductListService.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

final class ProductListService {
    private let client = NetworkClient()
    private let request = AdvertismtentsRequest()

    func getAds(completion: @escaping (Result<Advertisements, Error>) -> Void) {
        client.send(request: request, type: Advertisements.self, completion: completion)
    }
}
