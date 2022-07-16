//
//  View + Extensions.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import SwiftUI

extension View {
    
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
    
    func showLoadingIndicator(
        isLoading: Bool,
        alignment: HorizontalAlignment = .center
    ) -> some View {
        overlay(alignment: Alignment(horizontal: alignment, vertical: .center)) {
            if isLoading {
                ProgressView()
            }
        }
    }
}
