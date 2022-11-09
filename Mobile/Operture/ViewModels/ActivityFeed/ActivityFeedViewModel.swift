//
//  ActivityFeedViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import Foundation

struct EventModel: Identifiable, Hashable {
    var id: UUID
    var pets: [String]
    var dateTime: Date
    var type: EventType
    var notes: String
}

class ActivityFeedViewModel: ObservableObject {
    @Published var events: Dictionary<Date, [EventModel]>
    
    init() {
        self.events = [:]
    }
    
    func load() {
        let pets = DataModel.current.getPets()
        let events = DataModel.current.getEvents().map { event in
            let petNames = event.pets.map { id in
                let pet = pets.first(where: { $0.id == id })!
                return pet.name
            }
            
            return EventModel(id: event.id, pets: petNames, dateTime: event.dateTime, type: event.type, notes: event.notes)
        }
        
        self.events = Dictionary(grouping: events, by: { event in
            let components = Calendar.current.dateComponents([.year, .month, .day], from: event.dateTime)
            let date = Calendar.current.date(from: components)
            return date!
        })
    }
}
