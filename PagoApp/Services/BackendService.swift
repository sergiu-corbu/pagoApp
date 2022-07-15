//
//  BackendService.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation

class BackendService {
    
    static var httpClient = HTTPClient(configuration: ClientConfiguration())
    
    struct ClientConfiguration: HTTPClientConfiguration {
        
        let serverURL: URL = Constants.API_URL
        
        let urlConfiguration: URLSessionConfiguration = {
            var config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 30.0
            return config
        }()
        
        let validStatusCodes: ClosedRange<Int> = (200...299)
        
        var httpHeaders: [String : String] = [:]
        
        func decodedError(data: Data) -> Error? {
            return nil
        }
    }
}
