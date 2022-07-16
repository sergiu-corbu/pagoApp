//
//  AddContactViewController.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import Foundation
import UIKit

class AddContactViewController: UIViewController {
    
    let viewModel: AddContactViewModel
    
    init(contact: Contact?) {
        self.viewModel = AddContactViewModel(contact: contact)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray
    }
}
