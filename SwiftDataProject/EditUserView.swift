//
//  EditUserView.swift
//  SwiftDataProject
//
//  Created by Weerawut Chaiyasomboon on 25/12/2567 BE.
//

import SwiftUI

struct EditUserView: View {
    @Bindable var user: User
    
    var body: some View {
        Form {
            TextField("Name", text: $user.name)
            TextField("City", text: $user.city)
            DatePicker("Join Date", selection: $user.joinDate)
        }
        .navigationTitle("Edit User")
        .padding()
    }
}

#Preview {
    EditUserView(user: User(name: "Taylor Swift", city: "LA", joinDate: .now))
}
