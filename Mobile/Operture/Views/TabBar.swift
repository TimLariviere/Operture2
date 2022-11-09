//
//  ContentView.swift
//  Operture
//
//  Created by Timothé Larivière on 10/10/2022.
//

import SwiftUI

struct TabBar: View {
    @Binding var language: Language
    @StateObject var viewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.tab) {
            ActivityFeedView()
                .tabItem {
                    Label("Activity feed", systemImage: "calendar")
                }
                .tag(Tab.activityFeed)
            
            PetsView()
                .tabItem {
                    Label("Pets", systemImage: "pawprint")
                }
                .tag(Tab.pets)
            
            BudgetView()
                .tabItem {
                    Label("Budget", systemImage: "chart.bar")
                }
                .tag(Tab.budget)
            
            SettingsView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.settings)
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(language: .constant(Language.english))
    }
}
