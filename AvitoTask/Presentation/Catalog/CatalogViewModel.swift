//
//  CatalogViewModel.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

final class CatalogViewModel {

    private let productListService = ProductListService()

    @Observable
    private(set) var ads = [Advertisement]()

    @Observable
    private(set) var error = NetworkClientError.none

    var index = 0

    init() {
        fillAdsArray()
    }

    func fillAdsArray() {
        initializeProducts()
    }

    private func initializeProducts() {
        productListService.getAds { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.ads = data.advertisements
                case .failure(let error as NetworkClientError):
                    self?.error = error
                case .failure(_):
                    assertionFailure("")
                }
            }
        }
    }
}
