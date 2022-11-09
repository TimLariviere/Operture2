//
//  SettingsViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var currentUser: User
    @Published var theme: Theme
    @Published var language: Language
    @Published var currencyUnit: CurrencyUnit
    @Published var weightUnit: WeightUnit
    @Published var familyMembers: [User]
    
    init() {
        let currentUser = DataModel.current.getCurrentUser()!
        let allUsers = DataModel.current.getUsers()
        
        self.currentUser = currentUser
        self.theme = .system
        self.language = .english
        self.currencyUnit = .euro
        self.weightUnit = .kg
        self.familyMembers = allUsers.filter { $0.id != currentUser.id }
    }
}
