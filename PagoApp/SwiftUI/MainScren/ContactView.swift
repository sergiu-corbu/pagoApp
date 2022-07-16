//
//  ContactView.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import SwiftUI

struct ContactView: View {
    
    let contact: Contact
    var showInitialsInProfilePicture: Bool = false
    let onSelect: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Button {
                onSelect()
            } label: {
                HStack(spacing: 16) {
                    contactProfilePicture
                    Text(contact.name)
                        .font(.system(size: 17, weight: .regular))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .renderingMode(.template)
                        .foregroundColor(.wildBlueYonder)
                }
                .padding(24)
                .background(Color.white)
            }
            .buttonStyle(.plain)
            Divider()
        }
    }
    
    private var contactInitials: some View {
        Circle()
            .fill(Color.slate)
            .frame(width: 46)
            .overlay {
                Text(contact.contactInitials)
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .bold))
            }
    }
    
    @ViewBuilder
    private var contactProfilePicture: some View {
        if showInitialsInProfilePicture {
            contactInitials
        } else {
            AsyncImage(url: Constants.randomImageURL) { phase in
                switch phase {
                case .failure(_):
                    contactInitials
                case .empty:
                    ProgressView()
                        .frame(width: 46, height: 46)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 46, height: 46)
                        .clipShape(Circle())
                @unknown default:
                    fatalError()
                }
            }
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContactView(contact: .mockContacts.first!, showInitialsInProfilePicture: true, onSelect: {})
            ContactView(contact: .mockContacts.first!, onSelect: {})
        }
    }
}
