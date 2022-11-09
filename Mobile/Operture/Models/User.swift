//
//  User.swift
//  Operture
//
//  Created by Timothé Larivière on 28/10/2022.
//

import Foundation

struct User: Identifiable, Hashable {
    var id: UUID
    var name: String
    var email: String
    var picture: String?
    
    var initials: String {
        return String(name.prefix(1))
    }
}
