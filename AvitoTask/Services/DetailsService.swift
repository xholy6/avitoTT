//
//  DetailsService.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

final class DetailsService {
    private let client = NetworkClient()
    private let request: DetailsRequest

    init(id: String) {
        self.request = DetailsRequest(id: id)
    }

    func getDetail(completion: @escaping (Result<Details, Error>) -> Void) {
        client.send(request: request, type: Details.self, completion: completion)
    }
}
