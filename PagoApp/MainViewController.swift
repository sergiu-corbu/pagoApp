//
//  MainViewController.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension BackendService {
    
    static func loadContacts() async throws -> [Contact] {
        return try await httpClient.create(
            request: .get, path: "users"
        ).decodedResponse()
    }
}
