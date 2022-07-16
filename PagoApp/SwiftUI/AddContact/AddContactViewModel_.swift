//
//  AddContactViewModel_.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation

extension AddContact {
    
    class ViewModel: ObservableObject {
        
        @Published var contact: Contact?
        @Published var selection: Selection?
        
        let state: State
        
        init(contact: Contact?) {
            self.contact = contact
            self.state = contact != nil ? .update : .addContact
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
            case .addContact: return "Save"
            case .update: return "Update"
            }
        }
    }
    
    enum Selection: Int, Hashable, Identifiable {
        case firstname, lastname, phone, email
        
        var id: Int {
            rawValue
        }
    }
}
