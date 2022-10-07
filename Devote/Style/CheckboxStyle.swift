//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Богдан Беннер on 7.10.22.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
				.foregroundColor(configuration.isOn ? .pink : .primary)
				.font(.system(size: 30, weight: .semibold, design: .rounded))
				.onTapGesture {
					configuration.isOn.toggle()
				}
			configuration.label
		}
	}
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
		Toggle(isOn: .constant(true)) {
			Text("Placeholder label")
		}
		.padding()
		.previewLayout(.sizeThatFits)
		.toggleStyle(CheckboxStyle())
    }
}
