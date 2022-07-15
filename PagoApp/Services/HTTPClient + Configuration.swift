//
//  HTTPClient + Configuration.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation

protocol HTTPClientConfiguration {
    
    var serverURL: URL { get }
    var urlConfiguration: URLSessionConfiguration { get }
    var validStatusCodes: ClosedRange<Int> { get }
    var httpHeaders: [String: String] { get }
    func decodedError(data: Data) -> Error?
}
