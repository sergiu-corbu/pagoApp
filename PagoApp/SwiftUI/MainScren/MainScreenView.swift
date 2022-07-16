//
//  MainScreen.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import SwiftUI

struct MainScreen {
    
    struct ContentView: View {
        
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                NavigationBar(title: "Contacte", titleAlignment: .leading) {
                    addContactButton
                }
                List {
                    VStack(alignment: .leading, spacing: 0) {
                        headerView
                        contactsList
                    }
                    .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                .background {
                    Color.slateBackground
                        .ignoresSafeArea(.container, edges: .bottom)
                }
                .refreshable {
                    await viewModel.fetchContacts()
                }
            }
            .showLoadingIndicator(isLoading: viewModel.isLoading)
        }
        
        private var addContactButton: some View {
            Button {
                viewModel.onSelectContact.send(nil)
            } label: {
                Image("addContact-icon")
                    .padding(8)
                    .background {
                        RoundedRectangle(cornerRadius: 7)
                            .stroke(Color.aliceBlue, lineWidth: 1)
                    }
            }
            .buttonStyle(.plain)
        }
        
        private var headerView: some View {
            Text("CONTACTELE MELE")
                .foregroundColor(.slateColor)
                .font(.system(size: 13, weight: .semibold))
                .padding(EdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 0))
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.slateBackground)
        }
        
        private var contactsList: some View {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(viewModel.contacts, id: \.id) { contact in
                    ContactView(
                        contact: contact,
                        showInitialsInProfilePicture: contact.id.isEven
                    ) {
                        viewModel.onSelectContact.send(contact)
                    }
                }
            }
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    
    static var viewModel = MainScreen.ViewModel()
    
    static var previews: some View {
        MainScreen.ContentView().environmentObject(viewModel)
    }
}
