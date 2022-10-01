//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Богдан Беннер on 1.10.22.
//

import SwiftUI

#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif
