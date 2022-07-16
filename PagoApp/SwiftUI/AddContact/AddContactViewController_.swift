//
//  AddContactViewController_.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

extension AddContact {
    
    class ViewController: UIHostingController<AnyView> {
        
        let viewModel: ViewModel
        private var cancellables = Set<AnyCancellable>()
        
        init(viewModel: ViewModel, rootView: ContentView = .init()) {
            self.viewModel = viewModel
            super.init(
                rootView: rootView
                    .environmentObject(viewModel)
                    .eraseToAnyView()
            )
            viewModel.onContactSaved
                .sink { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }.store(in: &cancellables)
        }
        
        required dynamic init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
