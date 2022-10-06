//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Богдан Беннер on 4.10.22.
//

import SwiftUI

struct NewTaskItemView: View {
		// MARK: Property
	@Environment(\.managedObjectContext) private var viewContext
	@State private var taskName = ""
	@Binding var isShowing: Bool
	@AppStorage("isDarkMode") private var isDarkMode = false
	private var isButtonDisabled: Bool {
		taskName.isEmpty
	}
		// MARK: Func
	private func addItem() {
		withAnimation {
			let newItem = Item(context: viewContext)
			newItem.timestamp = Date()
			newItem.task = taskName
			newItem.completion = false
			newItem.id = UUID()
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
			taskName = ""
			hideKeyboard()
			isShowing = false
		}
	}
		// MARK: Body
    var body: some View {
		VStack {
			Spacer()
			VStack(spacing: 16) {
				TextField("New Task", text: $taskName)
					.foregroundColor(.pink)
					.font(.system(size: 24, weight: .bold, design: .rounded))
					.padding()
					.background(isDarkMode ? Color(UIColor.tertiarySystemBackground) : Color(UIColor.secondarySystemBackground))
					.cornerRadius(10)
				Button {
					addItem()
				} label: {
					Spacer()
					Text("Save")
						.font(.system(size: 24, weight: .bold, design: .rounded))
					Spacer()
				}
				.padding()
				.font(.headline)
				.foregroundColor(.white)
				.background(isButtonDisabled ? Color.blue : Color.pink)
				.cornerRadius(10)
				.disabled(isButtonDisabled)
				
			}
			.padding(.horizontal)
			.padding(.vertical, 20)
			.background(isDarkMode ? Color(UIColor.secondarySystemBackground) : Color.white)
					.cornerRadius(16)
					.shadow(color: .black, radius: 24)
					.frame(maxWidth: 640)
		}
		.padding()
    }
}

struct NewTaskItemView_Previews: PreviewProvider {
    static var previews: some View {
		NewTaskItemView(isShowing: .constant(true))
			.background(Color.gray.edgesIgnoringSafeArea(.all))
    }
}
