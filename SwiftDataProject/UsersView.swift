//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Weerawut Chaiyasomboon on 25/12/2567 BE.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    @Query var users: [User]
    @Binding var selectedUser: User?
    
    init(selectedUser: Binding<User?>, minimumJoinDate: Date = .now, sortOrder: [SortDescriptor<User>] = []) {
        _selectedUser = selectedUser
        _users = Query(
            filter: #Predicate<User> { user in
                user.joinDate >= minimumJoinDate
            },
            sort: sortOrder)
    }
    
    var body: some View {
        List(users, selection: $selectedUser) { user in
            NavigationLink(value: user) {
                HStack {
                    Text(user.name)
                    
                    Spacer()
                    
                    Text(String(user.jobs.count))
                        .fontWeight(.black)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .clipShape(.capsule)
                }
            }
        }
    }
}

#Preview {
    UsersView(selectedUser: .constant(nil))
}
