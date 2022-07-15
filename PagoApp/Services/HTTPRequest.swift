//
//  HTTPRequest.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation

struct HTTPRequest {
    
    let urlRequest: URLRequest
    let session: URLSession
    let configuration: HTTPClientConfiguration
    
    func validate(response: URLResponse, data: Data?) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw HTTPRequestError.invalidHttpStatusCode(-1)
        }
        let apiError: Error? = data.flatMap {
            configuration.decodedError(data: $0)
        }
        guard configuration.validStatusCodes.contains(statusCode) else {
            
            print("\n Request failed: ",
                  urlRequest.httpMethod ?? "",
                  urlRequest.url?.absoluteString ?? "",
                  "\n\tResponse: " + (data.flatMap({ String(data:$0, encoding: .utf8) }) ?? ""))
            throw apiError ?? HTTPRequestError.invalidHttpStatusCode(statusCode)
        }
        if let error = apiError {
            throw error
        }
    }
    
    func voidResponse() async throws {
        let (data, response): (Data, URLResponse) = try await session.data(for: urlRequest)
        try validate(response: response, data: data)
    }
    
    func decodedResponse<T: Decodable>(decoder: JSONDecoder = .init()) async throws -> T {
        let (data, response): (Data, URLResponse) = try await session.data(for: urlRequest)
        try validate(response: response, data: data)
        do {
            let object = try decoder.decode(T.self, from: data)
            return object
        } catch {
            print("unknown error", error.localizedDescription)
            throw error
        }
    }
}

@available(iOS 13.0, *)
extension URLSession {
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = self.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(throwing: HTTPRequestError.invalidRequestResponse)
                }
            }
            task.resume()
        }
    }
}
