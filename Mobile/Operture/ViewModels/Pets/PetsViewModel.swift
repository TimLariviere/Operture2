//
//  PetsViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import Foundation

class PetsViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    
    func load() {
        self.pets = DataModel.current.getPets()
    }
}
