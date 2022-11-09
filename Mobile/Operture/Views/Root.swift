//
//  Root.swift
//  Operture
//
//  Created by Timothé Larivière on 28/10/2022.
//

import SwiftUI

enum Route: Hashable {
    case signIn
    case selectFamily
    case home
}

struct Root: View {
    @Binding var language: Language
    @State private var route = Route.signIn
    
    var body: some View {
        switch route {
        case .signIn:
            SignInView() { hasFamily in
                if hasFamily {
                    route = .home
                }
                else {
                    route = .selectFamily
                }
            }
            
        case .selectFamily:
            SelectFamilyView() {
                route = .home
            }
            
        case .home:
            TabBar(language: $language)
        }
    }
}

struct Root_Previews: PreviewProvider {
    static var previews: some View {
        Root(language: .constant(Language.english))
    }
}
