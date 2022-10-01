//
//  ContentView.swift
//  Devote
//
//  Created by Богдан Беннер on 25.09.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
	// MARK: Property
	@State var taskName = ""
	private var isButtonDisabled: Bool {
		taskName.isEmpty
	}
	// MARK: Fetching data
	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
		animation: .default)
	private var items: FetchedResults<Item>
	// MARK: Functions
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
		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map { items[$0] }.forEach(viewContext.delete)
			
			do {
				try viewContext.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
	var body: some View {
		NavigationView {
			VStack {
				VStack(spacing: 16) {
					TextField("New Task", text: $taskName)
						.padding()
						.background(Color(.systemGray6))
						.cornerRadius(10)
					Button {
						addItem()
					} label: {
						Spacer()
						Text("Save")
						Spacer()
					}
					.padding()
					.font(.headline)
					.foregroundColor(.white)
					.background(isButtonDisabled ? Color.gray : Color.pink)
					.cornerRadius(10)
					.disabled(isButtonDisabled)
				}
				.padding()
				List {
					ForEach(items) { item in
							VStack(alignment: .leading) {
								Text(item.task ?? "")
									.font(.headline)
									.fontWeight(.bold)
								Text("Item at \(item.timestamp!, formatter: itemFormatter)")
									.font(.footnote)
									.foregroundColor(.gray)
						}
					}
					.onDelete(perform: deleteItems)
				}
			}
			.navigationTitle("Daily Tasks")
			//navigationBarTitleDisplayMode(.large)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: addItem) {
						Label("Add Item", systemImage: "plus")
					}
				}
			}
		}
	}
}
struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
