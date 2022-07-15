//
//  HTTPClient.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation

class HTTPClient {
    
    let configuration: HTTPClientConfiguration
    var session: URLSession
    
    init(configuration: HTTPClientConfiguration) {
        self.configuration = configuration
        self.session = URLSession(configuration: configuration.urlConfiguration)
    }
    
    func create(request method: HTTPMethod, path: String) throws -> HTTPRequest {
        let url = configuration.serverURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return HTTPRequest(urlRequest: request, session: session, configuration: configuration)
    }
}

extension HTTPClient {
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
}
