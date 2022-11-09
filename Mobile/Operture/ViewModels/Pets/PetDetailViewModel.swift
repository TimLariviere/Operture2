//
//  PetDetailViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 27/10/2022.
//

import Foundation

class PetDetailViewModel: ObservableObject {
    @Published var picture: String?
    @Published var name: String
    @Published var birthdate: Date
    @Published var type: PetType
    @Published var sex: PetSex
    @Published var race: String?
    @Published var colors: String?
    @Published var currentWeight: WeightMeasurement?
    @Published var nextVeterinaryVisit: VeterinaryVisit?
    
    private var originalData: Pet
    
    var initials: String {
        String(name.prefix(1))
    }
    
    init(_ id: UUID) {
        let pet = DataModel.current.getPet(id)!
        
        self.originalData = pet
        
        self.picture = pet.picture
        self.name = pet.name
        self.birthdate = pet.birthDate
        self.type = pet.type
        self.sex = pet.sex
        self.race = pet.race
        self.colors = pet.colors
        self.currentWeight = WeightMeasurement(id: UUID(), petId: pet.id, date: Date(), value: 4.5)
        self.nextVeterinaryVisit = VeterinaryVisit(id: UUID(), petId: pet.id, type: .yearlyCheckup, date: Date.from(year: 2022, month: 12, day: 01))
    }

    func save() {
        var updatedPet = self.originalData
        updatedPet.name = self.name
        updatedPet.birthDate = self.birthdate
        updatedPet.type = self.type
        updatedPet.sex = self.sex
        updatedPet.race = self.race
        updatedPet.colors = self.colors
        
        DataModel.current.setPet(self.originalData.id, pet: updatedPet)
    }
}
