//
//  Event.swift
//  Operture
//
//  Created by Timothé Larivière on 21/10/2022.
//

import Foundation
import SwiftUI

enum EventType: CaseIterable {
    case appointment
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .appointment:
            return "Appointment"
        }
    }
}

struct Event: Identifiable, Hashable {
    var id: UUID
    var type: EventType
    var notes: String
    var dateTime: Date
    var pets: [UUID]
    var people: [UUID]
}
