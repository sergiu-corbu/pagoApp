//
//  MainScreenViewController.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

extension MainScreen {
    
    class ViewController: UIHostingController<AnyView> {
     
        let viewModel = ViewModel()
        
        private var cancellables = Set<AnyCancellable>()
        
        init(rootView: ContentView = .init()) {
            super.init(
                rootView: rootView
                    .environmentObject(viewModel)
                    .eraseToAnyView()
            )
            setupBindings()
        }
        
        private func showAddContactView(_ contact: Contact?) {
            
            let addContactViewModel = AddContact.ViewModel(
                contactDataSource: viewModel.contactDataSource,
                contact: contact
            )
            addContactViewModel.onContactSaved
                .receive(on: DispatchQueue.main)
                .sink { [weak self] contact in
                    self?.navigationController?.popViewController(animated: true)
                    self?.viewModel.handleAddedOrUpdatedContact(contact)
                }.store(in: &cancellables)
            
            navigationController?.pushViewController(
                AddContact.ViewController(viewModel: addContactViewModel),
                animated: true
            )
        }
        
        private func setupBindings() {
            viewModel.onSelectContact
                .sink { [weak self] contact in
                    self?.showAddContactView(contact)
                }
                .store(in: &cancellables)
        }
        
        required dynamic init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
