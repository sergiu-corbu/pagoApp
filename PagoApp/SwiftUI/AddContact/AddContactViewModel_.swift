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
        
        @Published var selection: Selection?
        @Published var isLoading = false
        
        @Published var contact: Contact
        @Published var firstName = ""
        @Published var lastName = ""
        @Published var phoneNumber = ""
        
        let state: State
        
        var primaryButtonEnabled: Bool {
            return true
        }
        
        let onContactSaved = PassthroughSubject<Void, Never>()
        
        init(contact: Contact?) {
            self.contact = contact ?? Contact()
            self.state = contact != nil ? .update : .addContact
        }
        
        func primaryButtonAction() {
            
        }
    }
}

typealias ContactSelection = AddContact.Selection

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
    
    enum Selection: Int, Hashable, Identifiable {
        case firstname, lastname, phone, email
        
        var title: String {
            switch self {
            case .firstname: return "PRENUME"
            case .lastname: return "NUME"
            case .phone: return "TELEFON"
            case .email: return "EMAIL"
            }
        }
        
        var id: Int {
            rawValue
        }
    }
}
