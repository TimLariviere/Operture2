//
//  User.swift
//  Operture
//
//  Created by Timothé Larivière on 25/10/2022.
//

import Foundation
import SwiftUI

struct Family: Identifiable {
    var id: UUID
    var country: Country
    var currency: CurrencyUnit
    var members: [UUID]
    var pets: [UUID]
}
