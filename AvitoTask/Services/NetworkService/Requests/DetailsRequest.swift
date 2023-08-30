//
//  DetailsRequest.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

struct DetailsRequest: NetworkRequest {
    let id: String

    var endpoint: URL? {
        get {
            URL(string: self.baseEndpoint + "details/" + "\(id).json")
        }
    }

}
