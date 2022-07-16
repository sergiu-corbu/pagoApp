//
//  ContactModel.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation
import UIKit

struct Contact: Identifiable, Hashable, Codable {
    
    let id: Int
    var name: String
    var email: String
    let gender: String
    let status: String
    var phoneNumber: String?
    
    var contactInitials: String {
        let firstInitial = name.first?.uppercased() ?? ""
        let secondInitial = name.components(separatedBy: " ").last?.first?.uppercased() ?? ""
        return firstInitial + secondInitial
    }
    
    // for iOS 13,14 - AsyncImage API not available
    func randomUIImage() -> UIImage? {
        let imageData = try? Data(contentsOf: Constants.randomImageURL)
        guard let imageData, let uiImage = UIImage(data: imageData) else {
            return nil
        }
        
        return uiImage
    }
}

extension Contact {
    
    //empty
    init() {
        self.id = Int.random(in: (0..<1000))
        self.name = ""
        self.gender = ""
        self.email = ""
        self.status = "active"
    }
}

extension Contact {
    static let mockContacts = Array(
        repeating: Contact(id: Int.random(in: (1...20)), name: "James Boooond", email: "", gender: "", status: ""),
        count: 20
    )
}
