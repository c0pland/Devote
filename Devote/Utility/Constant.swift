//
//  Constant.swift
//  Devote
//
//  Created by Богдан Беннер on 29.09.22.
//

import SwiftUI
// MARK: Formatter
let itemFormatter: DateFormatter = {
	let formatter = DateFormatter()
	formatter.dateStyle = .short
	formatter.timeStyle = .medium
	return formatter
}()

// MARK: UI
var backgroundGradient: LinearGradient {
	LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
}
// MARK: UX
let feedback = UINotificationFeedbackGenerator()
