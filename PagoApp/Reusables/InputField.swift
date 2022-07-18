//
//  InputField.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import SwiftUI

struct InputField: View {
    
    @Binding var input: String
    let contctProperty: ContactProperty
    var error: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            titleView
            inputView
        }
        .padding(16)
        .background {
            Color.white
                .cornerRadius(12)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(error != nil ? Color.red : .clear, lineWidth: 1.5)
        }
        .padding(.horizontal, 16)
    }
    
    private var titleView: some View {
        Text(contctProperty.title)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.gray)
    }
    
    private var inputView: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("", text: $input)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(error != nil ? .red : .black)
                .disableAutocorrection(true)
            if let error = error {
                Text(error)
                    .foregroundColor(.red)
                    .font(.system(size: 12))
                    .transition(
                        .opacity.animation(.easeInOut(duration: 0.25))
                    )
            }
            Divider()
        }
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputField(input: .constant(""), contctProperty: .firstname)
            InputField(input: .constant("some email"), contctProperty: .email)
            InputField(input: .constant("07774"), contctProperty: .phone, error: "Invalid phone")
        }
        .padding()
        .background {
            Color.slateBackground
        }
    }
}
