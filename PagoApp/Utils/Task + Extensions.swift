//
//  Task + Extensions.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 16.07.2022.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    
    static func sleep(seconds: TimeInterval) async {
        let duration = UInt64(seconds * 1_000_000_000)
        try? await sleep(nanoseconds: duration)
    }
}
