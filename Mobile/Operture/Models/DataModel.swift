//
//  Data.swift
//  Operture
//
//  Created by Timothé Larivière on 28/10/2022.
//

import Foundation

class DataModel {
    private var currentUserId: UUID?
    private var family: Family?
    private var users: [User]
    private var pets: [Pet]
    private var weightMeasurements: [WeightMeasurement]
    private var events: [Event]
    
    static let current = DataModel()
    
    private init() {
        currentUserId = nil
        family = nil
        users = []
        pets = []
        weightMeasurements = []
        events = []
    }
    
    func hasCurrentUser() -> Bool {
        self.currentUserId != nil
    }
    
    func getCurrentUser() -> User? {
        guard let currentUserId = self.currentUserId else {
            return nil
        }
        
        return self.getUser(currentUserId)
    }
    
    func setCurrentUser(_ user: User) {
        self.currentUserId = user.id
        self.users.append(user)
    }
    
    func isCurrentUser(id: UUID) -> Bool {
        self.currentUserId == id
    }
    
    func getUser(_ id: UUID) -> User? {
        return self.users.first { $0.id == id }
    }
    
    func getUsers() -> [User] {
        self.users
    }
    
    func addUser(_ user: User) {
        self.users.append(user)
    }
    
    func setUser(id: UUID, user: User) {
        if let i = self.users.firstIndex(where: { $0.id == id }) {
            self.users[i] = user
        }
    }
    
    func removeUser(id: UUID) {
        if let i = self.users.firstIndex(where: { $0.id == id }) {
            self.users.remove(at: i)
        }
    }
    
    func setFamily(_ family: Family) {
        self.family = family
    }
    
    func getPet(_ id: UUID) -> Pet? {
        self.pets.first(where: { $0.id == id })
    }
    
    func setPet(_ id: UUID, pet: Pet) {
        if let i = self.pets.firstIndex(where: { $0.id == id }) {
            self.pets[i] = pet
        }
    }
    
    func getPets() -> [Pet] {
        self.pets
    }
    
    func addPet(_ pet: Pet) {
        self.pets.append(pet)
    }
    
    func getEvent(_ id: UUID) -> Event? {
        self.events.first(where: { $0.id == id })
    }
    
    func getEvents() -> [Event] {
        self.events
    }
    
    func addEvent(_ event: Event) {
        self.events.append(event)
    }
}
