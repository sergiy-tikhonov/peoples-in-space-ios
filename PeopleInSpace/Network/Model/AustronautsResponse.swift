//
//  AustronautsResponse.swift
//  PeopleInSpace
//
//  Created by Serhii on 06.05.2024.
//

import Foundation

struct AustronautsReponse: Codable {
    let message: String
    let number: Int
    let people: [Austronaut]
}
