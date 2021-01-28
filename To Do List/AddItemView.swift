//
//  AddItemView.swift
//  To Do List
//
//  Created by Tom Bredemeier on 1/28/21.
//

import SwiftUI

struct AddItemView: View {
    @ObservedObject var toDoList: ToDoList
        @State private var priority = ""
        @State private var description = ""
        @State private var dueDate = Date()
        @Environment(\.presentationMode) var presentationMode
        static let priorites = ["High", "Medium", "Low"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Priority", selection: $priority) {
                    ForEach(Self.priorites, id: \.self) { priority in
                        Text(priority)
                    }
                }
                TextField("Description", text: $description)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
            }
            .navigationBarTitle("Add New To-Do Item")
            .navigationBarItems(trailing: Button("Save") {
                if priority.count > 0 && description.count > 0 {
                    let item = ToDoItem(id: UUID(), priority: priority, description: description, dueDate: dueDate)
                    toDoList.items.append(item)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(toDoList: ToDoList())
    }
}
