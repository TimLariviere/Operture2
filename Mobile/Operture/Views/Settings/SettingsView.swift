//
//  SettingsView.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                user
                settings
                familyMembers
                destructiveActions
            }
            .navigationTitle("Settings")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user.id)
            }
        }
    }
    
    var user: some View {
        Section {
            NavigationLink(value: viewModel.currentUser) {
                personCell(viewModel.currentUser)
            }
            
            Button(role: .destructive) {
                
            } label: {
                Text("Sign out")
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    var settings: some View {
        Section {
            Picker("Theme", selection: $viewModel.theme) {
                ForEach(Theme.allCases, id: \.self) { theme in
                    Text(theme.localizedKey)
                }
            }
            Picker("Language", selection: $viewModel.language) {
                ForEach(Language.allCases, id: \.self) { language in
                    Text(language.name)
                }
            }
            Picker("Currency unit", selection: $viewModel.currencyUnit) {
                ForEach(CurrencyUnit.allCases, id: \.self) { unit in
                    Text(unit.localizedKey)
                }
            }
            Picker("Weight unit", selection: $viewModel.weightUnit) {
                ForEach(WeightUnit.allCases, id: \.self) { unit in
                    Text(unit.localizedKey)
                }
            }
        }
    }
    
    var familyMembers: some View {
        Section("Family members") {
            ForEach(viewModel.familyMembers) { member in
                NavigationLink(value: member) {
                    personCell(member)
                }
            }
        }
    }
    
    var destructiveActions: some View {
        Button(role: .destructive) {
            
        } label: {
            Text("Delete family")
        }
    }
    
    func personCell(_ user: User) -> some View {
        HStack(spacing: 20) {
            AvatarImage(user.picture, initials: user.initials)
                .frame(width: 60, height: 60)
            
            VStack {
                Text(user.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(user.email)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
