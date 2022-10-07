//
//  ListRowItemView.swift
//  Devote
//
//  Created by Богдан Беннер on 7.10.22.
//

import SwiftUI

struct ListRowItemView: View {
	@Environment(\.managedObjectContext) var viewContext
	@ObservedObject var item: Item
    var body: some View {
		Toggle(isOn: $item.completion) {
			Text(item.task ?? "")
				.font(.system(.title2, design: .rounded, weight: .heavy))
				.foregroundColor(item.completion ? .pink : .primary)
				.padding(.vertical, 12)
				.animation(.default)
		}
		.toggleStyle(CheckboxStyle())
		.onReceive(item.objectWillChange) { _ in
			if self.viewContext.hasChanges {
				try? self.viewContext.save()
			}
		}
    }
}
