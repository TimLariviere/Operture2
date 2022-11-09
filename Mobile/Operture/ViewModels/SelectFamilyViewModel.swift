//
//  SelectFamilyView.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import Foundation

class SelectFamilyViewModel: ObservableObject {
    
    private func createFakeFamily() {
        let otherMember = User(id: UUID(), name: "Rui", email: "77ruizhang@gmail.com", picture: "ProfilePicture2")
        DataModel.current.addUser(otherMember)
        
        let pet1 = Pet(id: UUID(), name: "Opéra", birthDate: Date.from(year: 2020, month: 7, day: 1), type: .cat, sex: .female, isDeceased: false, picture: "Opera")
        DataModel.current.addPet(pet1)
        
        let pet2 = Pet(id: UUID(), name: "Juju", birthDate: Date.from(year: 2022, month: 11, day: 1), type: .cat, sex: .male, isDeceased: false)
        DataModel.current.addPet(pet2)
        
        let currentUser = DataModel.current.getCurrentUser()!
        let family = Family(id: UUID(), country: .netherlands, currency: .euro, members: [ currentUser.id, otherMember.id ], pets: [ pet1.id, pet2.id ])
        DataModel.current.setFamily(family)
        
        let evt1 = Event(id: UUID(), type: .appointment, notes: "", dateTime: Date.from(year: 2022, month: 12, day: 1), pets: [ pet1.id ], people: [])
        DataModel.current.addEvent(evt1)
    }
    
    func joinFamily() {
        createFakeFamily()
    }
    
    func createFamily() {
        createFakeFamily()
    }
}
