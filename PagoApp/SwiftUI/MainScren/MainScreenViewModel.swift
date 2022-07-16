//
//  MainScreenViewModel.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import Combine

extension MainScreen {
    
    class ViewModel: ObservableObject {
       
        @Published var contacts: [Contact] = []
        @Published var isLoading = true
        
        let onSelectContact = PassthroughSubject<Contact?, Never>()
        
        init() {
            contacts = Contact.mockContacts
//            Task(priority: .background) {
//                await fetchContacts()
//            }
        }
        
        func fetchContacts() async {
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
            await MainActor.run {
                isLoading = false
            }
        }
    }
}
