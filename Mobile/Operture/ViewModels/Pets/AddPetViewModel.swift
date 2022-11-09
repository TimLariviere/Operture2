//
//  AddPetViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 27/10/2022.
//

import Foundation

class AddPetViewModel: ObservableObject {
    @Published var picture: String?
    @Published var name: String
    @Published var birthdate: Date
    @Published var type: PetType
    @Published var sex: PetSex
    @Published var race: String?
    @Published var colors: String?
    
    var initials: String {
        String(self.name.prefix(1))
    }
    
    init() {
        self.picture = nil
        self.name = ""
        self.birthdate = Date()
        self.type = .cat
        self.sex = .male
        self.race = nil
        self.colors = nil
    }
}
