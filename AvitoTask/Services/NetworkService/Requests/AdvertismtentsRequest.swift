//
//  AdvertismtentsRequest.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

struct AdvertismtentsRequest: NetworkRequest {
    
    var endpoint: URL? {
        get {
            URL(string: self.baseEndpoint + "main-page.json")
        }
    }

}
