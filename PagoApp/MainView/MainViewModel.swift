//
//  MainViewModel.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation
import UIKit

class MainViewModel {
    
    var isLoading: Bool = true
    
    private(set) var contacts: [Contact] = [] {
        didSet {
            tableView?.reloadData()
        }
    }
    
    weak var tableView: UITableView?
    
    init() {
        Task(priority: .background) {
            await fetchContacts()
        }
    }
    
    private func fetchContacts() async {
        do {
            let contacts = try await BackendService.loadContacts().filter {
                $0.status == "active"
            }
            await MainActor.run(body: {
                self.contacts = contacts
            })
        } catch {
            print(error.localizedDescription)
        }
        isLoading = false
    }
}
