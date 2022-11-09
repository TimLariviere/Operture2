//
//  OpertureApp.swift
//  Operture
//
//  Created by Timothé Larivière on 10/10/2022.
//

import SwiftUI

@main
struct OpertureApp: App {
    @State(initialValue: Language.english) var language: Language
    
    var body: some Scene {
        WindowGroup {
            Root(language: $language)
                .environment(\.locale, .init(identifier: language.code))
        }
    }
}
