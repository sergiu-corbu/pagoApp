//
//  ContactModel.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation

struct Contact: Identifiable, Hashable, Codable {
    
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
}

extension Contact {
    static let mockContacts = Array(
        repeating: Contact(id: Int.random(in: (1...20)), name: "James Boooond", email: "", gender: "", status: ""),
        count: 20
    )
}
