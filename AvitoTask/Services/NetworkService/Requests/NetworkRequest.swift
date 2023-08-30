//
//  NetworkRequest.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

protocol NetworkRequest {
    var endpoint: URL? { get }
}

// default values
extension NetworkRequest {
    var baseEndpoint: String { "https://www.avito.st/s/interns-ios/" }
}
