//
//  ApiService.swift
//  PeopleInSpace
//
//  Created by Serhii on 06.05.2024.
//

import Foundation

class ApiService {
    
    static let shared = ApiService()
    
    let AUSTRONAUTS_LIST_URL = "https://people-in-space-proxy.ew.r.appspot.com/astros.json"
    
    func loadAustronauts() async throws -> AustronautsReponse {
        let url = URL(string: AUSTRONAUTS_LIST_URL)!
        let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.badRequest
            }
            let jsonDecoder = JSONDecoder()
            do {
                let austronautsResponse = try jsonDecoder.decode(AustronautsReponse.self, from: data)
                return austronautsResponse
            } catch {
                throw NetworkError.decodingError
            }
    }
    
}

enum NetworkError: Error {
    case badRequest
    case decodingError
    case unknown(Error?)
}
