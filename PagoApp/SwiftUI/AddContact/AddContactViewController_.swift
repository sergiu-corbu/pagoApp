//
//  AddContactViewController_.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation
import UIKit
import SwiftUI

extension AddContact {
    
    class ViewController: UIHostingController<AnyView> {
        
        let viewModel: ViewModel
        
        init(viewModel: ViewModel, rootView: ContentView = .init()) {
            self.viewModel = viewModel
            super.init(
                rootView: rootView
                    .environmentObject(viewModel)
                    .eraseToAnyView()
            )
        }
        
        required dynamic init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
