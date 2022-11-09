//
//  SignInViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 24/10/2022.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    func signIn() {
        let user = User(id: UUID(), name: "Timothé", email: "timothe.lariviere@outlook.com", picture: "ProfilePicture")
        DataModel.current.setCurrentUser(user)
    }
}
