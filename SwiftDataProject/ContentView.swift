//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Weerawut Chaiyasomboon on 25/12/2567 BE.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
//    @Query(sort:\User.name) var users: [User]
//    @Query(
//        filter: #Predicate<User> {
//            user in user.name.localizedStandardContains(
//                "R"
//            ) && user.city == "London"
//        },
//        sort: \User.name) var users: [User]
    
    @State private var showingUpcomingOnly = false
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.joinDate),
    ]
    
    @State var selectedUser: User?
    
    var body: some View {
        NavigationSplitView {
            UsersView(selectedUser: $selectedUser, minimumJoinDate: showingUpcomingOnly ? .now : .distantPast, sortOrder: sortOrder)
        } detail: {
            if let selectedUser {
                EditUserView(user: selectedUser)
            } else {
                Text("Select a user")
            }
        }
        .toolbar {
            Button("Add User", systemImage: "plus") {
                let user = User(name: "", city: "", joinDate: .now)
                modelContext.insert(user)
                selectedUser = user
            }
            
            Button("Add Samples", systemImage: "person.3") {
                try? modelContext.delete(model: User.self)
                let first = User(name: "Ed Sheeran",city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))
                
                let job1 = Job(name: "Organize sock drawer", priority: 3)
                let job2 = Job(name: "Write next album", priority: 4)
                first.jobs.append(job1)
                first.jobs.append(job2)

                modelContext.insert(first)
                modelContext.insert(second)
                modelContext.insert(third)
                modelContext.insert(fourth)
            }
            
            Button(showingUpcomingOnly ? "Show Everyone" : "Show Upcoming") {
                showingUpcomingOnly.toggle()
            }
            
            Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("Sort", selection: $sortOrder) {
                    Text("Sort by Name")
                        .tag([
                            SortDescriptor(\User.name),
                            SortDescriptor(\User.joinDate),
                        ])
                    
                    Text("Sort by Join Date")
                        .tag([
                            SortDescriptor(\User.joinDate),
                            SortDescriptor(\User.name)
                        ])
                }
            }
        }

    }
}

#Preview {
    ContentView()
}
