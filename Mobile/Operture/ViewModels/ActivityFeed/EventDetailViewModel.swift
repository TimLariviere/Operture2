//
//  EventDetailViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 28/10/2022.
//

import Foundation

class EventDetailViewModel: ObservableObject {
    @Published var type: EventType
    @Published var dateTime: Date
    @Published var pets: [Pet]
    @Published var people: [User]
    
    init(_ id: UUID) {
        guard let event = DataModel.current.getEvent(id) else {
            print("invalid")
            self.type = .appointment
            self.dateTime = Date()
            self.pets = []
            self.people = []
            return
        }
        
        let pets = DataModel.current.getPets().filter { pet in
            event.pets.contains(where: { $0 == pet.id })
        }
        let people = DataModel.current.getUsers().filter { user in
            event.people.contains(where: { $0 == user.id })
        }
        
        self.type = event.type
        self.dateTime = event.dateTime
        self.pets = pets
        self.people = people
    }
    
    func save() {
        
    }
}
