//
//  Country.swift
//  Operture
//
//  Created by Timothé Larivière on 24/10/2022.
//

import Foundation
import SwiftUI

enum Country: CaseIterable {
    case france, netherlands
    
    func toString() -> String {
        switch self {
        case .france:
            return "🇫🇷 France"
        case .netherlands:
            return "🇳🇱 Netherlands"
        }
    }
}

enum CurrencyUnit: CaseIterable {
    case euro, yuan
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .euro:
            return "€ - Euro"
        case .yuan:
            return "¥‎ - Yuan"
        }
    }
}

enum WeightUnit: CaseIterable {
    case kg, lb
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .kg:
            return "kg - Kilogram"
        case .lb:
            return "lb - Pounds"
        }
    }
}

enum Language: CaseIterable {
    case english, french, chinese, dutch
    
    var name: String {
        switch self {
        case .english:
            return "English"
            
        case .french:
            return "Français"
            
        case .chinese:
            return "中文"
            
        case .dutch:
            return "Nederlands"
        }
    }
    
    var code: String {
        switch self {
        case .english:
            return "en"
            
        case .french:
            return "fr"
            
        case .chinese:
            return "zh"
            
        case .dutch:
            return "nl"
        }
    }
}

enum Theme: CaseIterable {
    case system, lightMode, darkMode
    
    var localizedKey: LocalizedStringKey {
        switch self {
        case .system:
            return "System settings"
            
        case .lightMode:
            return "Light mode"
            
        case .darkMode:
            return "Dark mode"
        }
    }
}
