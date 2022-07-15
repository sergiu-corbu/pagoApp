//
//  HTTPrequestError.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation

enum HTTPRequestError: Error, LocalizedError {
    case invalidHttpStatusCode(Int)
    case invalidRequestResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidHttpStatusCode(let code):
            return "Response status code was unacceptable: \(code)."
        case .invalidRequestResponse:
            return "Response could not be validated, no data received."
        }
    }
}
