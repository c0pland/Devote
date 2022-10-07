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
	@State private var showNewTaskItem = false
	@AppStorage("isDarkMode") private var isDarkMode = false
	// MARK: Fetching data
	@Environment(\.managedObjectContext) private var viewContext
	
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
		animation: .default)
	private var items: FetchedResults<Item>
	// MARK: Functions
	
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
			ZStack {
					// MARK: Main View
				VStack {
						// MARK: Header
					HStack(spacing: 10) {
							// MARK: title
						Text("Devote")
							.font(.system(.largeTitle, design: .rounded, weight: .heavy))
							.padding(.leading, 4)
						Spacer()
							// MARK: edit button
						EditButton()
							.font(.system(size: 16, weight: .semibold, design: .rounded))
							.padding(.horizontal, 10)
							.frame(minWidth: 70, minHeight: 24)
							.background(
								Capsule().stroke(Color.white, lineWidth: 2)
							)
							// MARK: appearance button
						Button {
							isDarkMode.toggle()
						} label: {
							Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
								.resizable()
								.frame(width: 24, height: 24)
								.font(.system(.title, design: .rounded))
						}

					}
					.padding()
					.foregroundColor(.white)
					Spacer(minLength: 80)
						// MARK: New task button
					Button {
						showNewTaskItem = true
					} label: {
						Image(systemName: "plus.circle")
							.font(.system(size: 30, weight: .semibold, design: .rounded))
						Text("New task")
							.font(.system(size: 24, weight: .bold, design: .rounded))
					}
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 15)
					.background(
						LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
							.clipShape(Capsule())
					)
					.shadow(color: .black, radius: 8, x: 0.0, y: 4.0)
						// MARK: Tasks
					
					List {
						ForEach(items) { item in
							ListRowItemView(item: item)
						}
						.onDelete(perform: deleteItems)
						//.listRowBackground(Color.clear)
					}
					// I've spent an hour to find this line...
					.scrollContentBackground(.hidden)
					.listStyle(InsetGroupedListStyle())
					.padding(.vertical, 0)
					.frame(maxWidth: 640)
				}
					// MARK: New task item
				if showNewTaskItem {
					BlankView()
						.onTapGesture {
							withAnimation {
								showNewTaskItem = false
							}
						}
					NewTaskItemView(isShowing: $showNewTaskItem)
				}
			}
			.onAppear() {
				UITableView.appearance().backgroundColor = UIColor.clear
			}
			.navigationTitle("Daily Tasks")
			.toolbar(.hidden)
			//navigationBarTitleDisplayMode(.large)
			.background(backgroundGradient.ignoresSafeArea(.all))
		}
		.navigationViewStyle(StackNavigationViewStyle())
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
