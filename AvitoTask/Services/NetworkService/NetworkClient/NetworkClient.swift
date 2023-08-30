//
//  NetworkService.swift
//  AvitoTask
//
//  Created by D on 30.08.2023.
//

import Foundation

enum NetworkClientError: Error {
    case httpStatusCode(Int)
    case urlSessionError
    case parsingError
    case invalidData
    case none
}

final class NetworkClient {

    func send<T: Decodable>(request: NetworkRequest, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = self.create(request: request) else { return }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkClientError.urlSessionError))
                return
            }

            guard 200 ..< 300 ~= response.statusCode else {
                completion(.failure(NetworkClientError.httpStatusCode(response.statusCode)))
                return
            }

            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkClientError.invalidData))
                }
                return
            }

            do {
                let result = try JSONDecoder().decode(type, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(NetworkClientError.parsingError))
            }
        }
        task.resume()
    }

    private func create(request: NetworkRequest) -> URLRequest? {
        guard let endpoint = request.endpoint else {
            assertionFailure("Empty endpoint")
            return nil
        }
        let urlRequest = URLRequest(url: endpoint)

        return urlRequest
    }

}
