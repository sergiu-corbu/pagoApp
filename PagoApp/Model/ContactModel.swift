//
//  ContactModel.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation

struct Contact: Identifiable, Codable {
    
    let id: Int
    let name: String
    let email: String
    let gender: String
    let status: String
}
