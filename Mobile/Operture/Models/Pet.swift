//
//  Pet.swift
//  Operture
//
//  Created by Timothé Larivière on 27/10/2022.
//

import Foundation
import SwiftUI

enum PetType: CaseIterable {
    case cat, dog
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .cat:
            return "Cat"
            
        case .dog:
            return "Dog"
        }
    }
}

enum PetSex: CaseIterable {
    case male, female
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .male:
            return "Male"
            
        case .female:
            return "Female"
        }
    }
}

struct WeightMeasurement: Identifiable {
    var id: UUID
    var petId: UUID
    var date: Date
    var value: Float
}

enum VeterinaryVisitType: CaseIterable {
    case yearlyCheckup
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .yearlyCheckup:
            return "Yearly check-up"
        }
    }
}

struct VeterinaryVisit: Identifiable {
    var id: UUID
    var petId: UUID
    var type: VeterinaryVisitType
    var date: Date
}

struct Pet: Identifiable, Hashable {
    var id: UUID
    var name: String
    var birthDate: Date
    var type: PetType
    var sex: PetSex
    var race: String?
    var colors: String?
    var chipNumber: String?
    var passportNumber: String?
    var isDeceased: Bool
    var picture: String?
    
    var weightGoal: Float?
    
    var initials: String {
        return String(name.prefix(1))
    }
    
    var age: Double {
        let dateComponents = Calendar.current.dateComponents([.year, .month], from: birthDate, to: Date())
        let totalYears = Double(dateComponents.year!) + (Double(dateComponents.month!) / 12.0)
        let rounded = Double(Int(totalYears / 0.5)) * 0.5
        return rounded
    }
}
