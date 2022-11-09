//
//  TabBarViewModel.swift
//  Operture
//
//  Created by Timothé Larivière on 26/10/2022.
//

import Foundation

enum Tab: Int {
    case activityFeed = 1
    case pets = 2
    case budget = 3
    case settings = 4
}

class TabBarViewModel: ObservableObject {
    @Published var tab: Tab = .activityFeed
}
