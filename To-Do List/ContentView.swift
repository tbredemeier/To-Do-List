//
//  ContentView.swift
//  To-Do List
//
//  Created by Tom Bredemeier on 1/23/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var toDoList = ToDoList()
    @State private var showingAddItemView = false
    var body: some View {
        NavigationView {
            List {
                ForEach(toDoList.items) { item in
                    HStack {
                        VStack(alignment: .leading, content: {
                            Text(item.priority)
                                .font(.headline)
                            Text(item.description)
                        })
                        Spacer()
                        Text(item.dueDate, style: .date)
                    }
                }
                .onMove(perform: { indices, newOffset in
                    toDoList.items.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    toDoList.items.remove(atOffsets: indexSet)
                })
            }
            .sheet(isPresented: $showingAddItemView, content: {
                AddItemView(toDoList: toDoList)
            })
            .navigationBarTitle("To Do List", displayMode: .inline)
            .navigationBarItems(leading: EditButton(),
                                trailing: Button(action: {
                showingAddItemView = true
            }, label: {
                Image(systemName: "plus")
            }))
        }
    }
}

#Preview {
    ContentView()
}

struct ToDoItem: Identifiable {
    var id = UUID()
    var priority = String()
    var description = String()
    var dueDate = Date()
}
