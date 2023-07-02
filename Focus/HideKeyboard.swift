//
//  HideKeyboard.swift
//  Focus
//
//  Created by Jack Radford on 29/06/2023.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    /// Hides the keyboard if it is active
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
