//
//  AddContactViewModel_.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import Combine

extension AddContact {
    
    class ViewModel: ObservableObject {
        
        @Published var isLoading = false
        @Published var contact: Contact
        @Published var firstName = ""
        @Published var lastName = ""
        @Published var phoneNumber = ""
        
        @Published var phoneNumberError: String?
        @Published var emailError: String?
        
        let state: State
        
        var primaryButtonEnabled: Bool {
            !firstName.isEmpty && !lastName.isEmpty
        }
        
        let onContactSaved = PassthroughSubject<Contact, Never>()
        
        let contactDataSource: ContactsDataSource
        
        init(contactDataSource: ContactsDataSource, contact: Contact?) {
            self.contactDataSource = contactDataSource
            if let contact {
                self.contact = contact
                let components = contact.name.components(separatedBy: " ")
                self.firstName = components.first ?? ""
                self.lastName = components.last ?? ""
                self.phoneNumber = contact.phoneNumber ?? ""
                self.state = .update
            } else {
                self.contact = Contact()
                self.state = .addContact
            }
        }
        
        @MainActor
        func primaryButtonAction() async {
            isLoading = true
            do {
                if !phoneNumber.isEmpty {
                    try Validation.validatePhoneNumber(for: phoneNumber)
                    contact.phoneNumber = phoneNumber
                }
                if !contact.email.isEmpty {
                    try Validation.validateEmail(for: contact.email)
                }
                
                contact.name = firstName + " " + lastName
                
                switch state {
                case .addContact:
                    await contactDataSource.addContacts([contact])
                case .update:
                    await contactDataSource.updateContact(contact)
                }
                
                onContactSaved.send(contact)
                
            } catch(let error as ValidationError) {
                print(error.localizedDescription)
                switch error {
                case .email:
                    emailError = error.localizedDescription
                case .phone:
                    phoneNumberError = error.localizedDescription
                default: break
                }
                await Task.sleep(seconds: 1.5)
                emailError = nil
                phoneNumberError = nil
            } catch {
                print(error.localizedDescription)
            }
            isLoading = false
        }
    }
}

typealias ContactProperty = AddContact.ContactProperty

extension AddContact {
    enum State {
        case addContact
        case update
        
        var primaryButtonTitle: String {
            switch self {
            case .addContact: return "Salveaza"
            case .update: return "Update"
            }
        }
    }
    
    enum ContactProperty: Int, Hashable {
        case firstname, lastname, phone, email
        
        var title: String {
            switch self {
            case .firstname: return "PRENUME"
            case .lastname: return "NUME"
            case .phone: return "TELEFON"
            case .email: return "EMAIL"
            }
        }
    }
}
