//
//  InputField.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import SwiftUI

struct InputField: View {
    
    @Binding var input: String
    let inputState: ContactSelection
    
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
        .padding(.horizontal, 16)
    }
    
    private var titleView: some View {
        Text(inputState.title)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(.gray)
    }
    
    private var inputView: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("", text: $input)
                .font(.system(size: 14, weight: .medium))
            Divider()
        }
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            InputField(input: .constant(""), inputState: .firstname)
            InputField(input: .constant("some email"), inputState: .email)
            InputField(input: .constant("07774"), inputState: .phone)
        }
        .padding()
        .background {
            Color.slateBackground
        }
    }
}
