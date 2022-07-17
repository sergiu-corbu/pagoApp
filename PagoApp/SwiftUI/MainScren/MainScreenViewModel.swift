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
        
        let contactDataSource = ContactsDataSource()
        
        init() {
            loadAndDownloadContacts()
        }
        
        private func loadAndDownloadContacts() {
            Task(priority: .background) {
                await fetchContacts()
                let storedContacts = await contactDataSource.loadExistingContacts()
                await MainActor.run {
                    self.contacts = storedContacts
                    isLoading = false
                }
            }
        }
        
        func fetchContacts() async {
            do {
                await contactDataSource.loadExistingContacts()
                let contacts = try await BackendService.loadContacts().filter {
                    $0.status == "active"
                }
                await contactDataSource.addContacts(contacts)
            } catch {
                print(error.localizedDescription)
                await MainActor.run {
                    isLoading = false
                }
            }
        }
        
        func handleAddedOrUpdatedContact(_ contact: Contact) {
            guard let contactIndex = contacts.firstIndex(where: {$0.id == contact.id }) else {
                contacts.append(contact)
                return
            }
            contacts[contactIndex] = contact
        }
    }
}
