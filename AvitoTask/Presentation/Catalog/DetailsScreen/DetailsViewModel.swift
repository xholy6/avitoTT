//
//  DetailsViewModel.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

final class DetailsViewModel {
    private var detailsService: DetailsService?

    @Observable
    private(set) var advertisement: Details? = nil

    @Observable
    private(set) var error = NetworkClientError.none

    var itemIndex = "0"

    deinit {
        print("deinited")
    }

     func fetchAd() {
        detailsService = DetailsService(id: itemIndex)
        detailsService?.getDetail {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.advertisement = data
                case .failure(let error as NetworkClientError):
                    self?.error = error
                case .failure(_):
                    assertionFailure("")
                }
            }
        }
    }
}

