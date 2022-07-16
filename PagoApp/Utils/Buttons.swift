//
//  Buttons.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import SwiftUI

struct Buttons {
    
    struct PrimaryButton: View {
        
        let title: String
        var tint: Color = .neonGreen
        var isEnabled: Bool = true
        var isLoading = false
        let action: () -> Void
        
        var body: some View {
            ZStack(alignment: .trailing) {
                Button {
                    action()
                } label: {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(14)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(
                    StandardButtonStyle(isEnabled: isEnabled, tint: tint)
                )
                .disabled(!isEnabled)
                
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .padding(.trailing)
                }
            }
            .padding([.horizontal, .bottom], 16)
        }
    }
}

struct StandardButtonStyle: ButtonStyle {
    
    let isEnabled: Bool
    let tint: Color
    
    private func labelOpacity(for configuration: Configuration) -> CGFloat {
        guard isEnabled else {
            return 0.6
        }
        return configuration.isPressed ? 0.9 : 1.0
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(tint.cornerRadius(12))
            .opacity(labelOpacity(for: configuration))
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.easeOut, value: configuration.isPressed)
    }
}

struct Buttons_Previews: PreviewProvider {
    
    static var previews: some View {
        VStack {
            Buttons.PrimaryButton(title: "Salveaza", action: {})
            Buttons.PrimaryButton(title: "Salveaza", isLoading: true,  action: {})
            Buttons.PrimaryButton(title: "Salveaza", isEnabled: false, action: {})
        }
    }
}
