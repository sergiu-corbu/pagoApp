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
                    InputField(input: $viewModel.lastName, inputState: .lastname)
                    InputField(input: $viewModel.firstName, inputState: .firstname)
                    InputField(input: $viewModel.phoneNumber, inputState: .phone)
                    InputField(input: $viewModel.contact.email, inputState: .email)
                }
                .padding(.vertical, 16)
            }
        }
        
        private var primaryButton: some View {
            Buttons.PrimaryButton(
                title: viewModel.state.primaryButtonTitle,
                isEnabled: viewModel.primaryButtonEnabled,
                isLoading: viewModel.isLoading,
                action: viewModel.primaryButtonAction
            )
        }
    }
}

struct AddContact_Previews: PreviewProvider {
    
    static var viewModel1 = AddContact.ViewModel(contact: .mockContacts.first)
    static var viewModel2 = AddContact.ViewModel(contact: nil)
    
    static var previews: some View {
        Group {
            AddContact.ContentView()
                .environmentObject(viewModel1)
            AddContact.ContentView()
                .environmentObject(viewModel2)
        }
    }
}
