//
//  AddContactView.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import SwiftUI

struct AddContact {
    
    struct ContentView: View {
    
        @EnvironmentObject var viewModel: ViewModel
    
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar(title: "Adauga contact", titleAlignment: .leading)
                inputFields
                primaryButton
            }
            .background {
                Color.slateBackground
                    .ignoresSafeArea(.container, edges: .bottom)
            }
        }
        
        private var inputFields: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    InputField(input: $viewModel.lastName, contctProperty: .lastname)
                    InputField(input: $viewModel.firstName, contctProperty: .firstname)
                    InputField(input: $viewModel.phoneNumber, contctProperty: .phone, error: viewModel.phoneNumberError)
                    InputField(input: $viewModel.contact.email, contctProperty: .email, error: viewModel.emailError)
                }
                .padding(.vertical, 16)
            }
        }
        
        private var primaryButton: some View {
            Buttons.PrimaryButton(
                title: viewModel.state.primaryButtonTitle,
                isEnabled: viewModel.primaryButtonEnabled,
                isLoading: viewModel.isLoading) {
                    Task(priority:  .userInitiated) {
                        await viewModel.primaryButtonAction()
                    }
                }
        }
    }
}

struct AddContact_Previews: PreviewProvider {
    
    static var viewModel1 = AddContact.ViewModel(contactDataSource: .init(), contact: .mockContacts.first)
    static var viewModel2 = AddContact.ViewModel(contactDataSource: .init(), contact: nil)
    
    static var previews: some View {
        Group {
            AddContact.ContentView()
                .environmentObject(viewModel1)
            AddContact.ContentView()
                .environmentObject(viewModel2)
        }
    }
}
