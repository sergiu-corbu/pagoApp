//
//  ContactsDataSource.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation

actor ContactsDataSource {
    
    private var contacts: [Int:Contact] = [:]
    
    private let fileManager: FileManager = .default
    private let contactDataFilePath = "ContactsData"
    
    lazy var jsonEncoder = JSONEncoder()
    
    private var storageURL: URL {
        get throws {
            try fileManager.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            .appendingPathComponent(self.contactDataFilePath)
        }
    }
    
    @discardableResult
    func loadExistingContacts() -> [Contact] {
        let contacts: [Contact]
        
        do {
            let jsonData = try Data(contentsOf: self.storageURL)
            contacts = try JSONDecoder().decode([Contact].self, from: jsonData)
        } catch (let error as NSError) {
            print(error.localizedDescription)
            contacts = []
        }
        
        self.contacts = Dictionary(uniqueKeysWithValues: contacts.map { ($0.id, $0) })
        return contacts
    }
    
    func updateContact(_ contact: Contact) {
        do {
            self.contacts.updateValue(contact, forKey: contact.id)
            let data = try jsonEncoder.encode(self.contacts)
            try data.write(to: self.storageURL, options: [.atomic])
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addContacts(_ contacts: [Contact]) {
        var newContacts = [Contact]()
        
        contacts.forEach {
            if self.contacts[$0.id] == nil {
                newContacts.append($0)
            }
        }
        
        guard !newContacts.isEmpty else {
            return
        }
        
        newContacts.append(contentsOf: self.contacts.values)
        
        do {
            let data = try jsonEncoder.encode(newContacts)

            try data.write(to: self.storageURL, options: [.atomic])
            
            newContacts.removeLast(self.contacts.count)

            newContacts.forEach {
                self.contacts.updateValue($0, forKey: $0.id)
            }

        } catch {
            print(error.localizedDescription)
            return
        }
    }
}

