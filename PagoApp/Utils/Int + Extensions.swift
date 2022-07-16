//
//  Int + Extensions.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation

extension Int {
    var isEven: Bool {
        self % 2 == 0
    }
    var isOdd: Bool {
        !isEven
    }
}
