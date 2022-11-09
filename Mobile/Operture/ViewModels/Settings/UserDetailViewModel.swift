//
//  UserDetailView.swift
//  Operture
//
//  Created by Timothé Larivière on 28/10/2022.
//

import Foundation

class UserDetailViewModel: ObservableObject {
    @Published var picture: String?
    @Published var name: String
    @Published var email: String
    
    private var originalData: User
    
    var isCurrentUser: Bool
    
    var initials: String {
        String(name.prefix(1))
    }
    
    init(_ id: UUID) {
        let user = DataModel.current.getUser(id)!
        
        self.originalData = user
        
        self.picture = user.picture
        self.name = user.name
        self.email = user.email
        self.isCurrentUser = DataModel.current.isCurrentUser(id: id)
    }
    
    func save() {
        var updatedUser = self.originalData
        
        updatedUser.name = self.name
        
        DataModel.current.setUser(id: self.originalData.id, user: updatedUser)
    }
    
    func delete(completion: () -> ()) {
        DataModel.current.removeUser(id: self.originalData.id)
        completion()
    }
}
