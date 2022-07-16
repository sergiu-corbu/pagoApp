//
//  Validation.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation

enum ValidationError: Error {
    case emptyText, email, phone
    
    var localizedDescription: String {
        switch self {
        case .emptyText: return "Text can not be empty"
        case .email: return "Invalid email format"
        case .phone: return "Invalid phone number"
        }
    }
}

enum Validation {
    
    fileprivate static func isValid(input: String, with regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: input)
    }
    
    fileprivate static func validateIsNotEmpty(input: String) throws {
        if input.isEmpty {
            throw ValidationError.emptyText
        }
    }
    
    static func validatePhoneNumber(for input: String) throws {
        try validateIsNotEmpty(input: input)
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        
        if !isValid(input: input, with: phoneRegex) {
            throw ValidationError.phone
        }
    }
    
    static func validateEmail(for input: String) throws {
        try validateIsNotEmpty(input: input)
        let mailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        if !isValid(input: input, with: mailRegex) {
            throw ValidationError.email
        }
    }
}
