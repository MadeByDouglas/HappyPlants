//
//  AppModel.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import Foundation

public enum UserKeys: String {
    case username = "username"
}

public enum NavigationItem {
    case myPlants
    case community
}

extension NavigationItem {
    var label: String {
        switch self {
        case .myPlants: return "My Plants"
        case .community: return "Community"
        }
    }
    
    var symbolName: String {
        switch self {
        case .myPlants: return "leaf"
        case .community: return "person.2.square.stack"
        }
    }
}

public func displayDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .short
    
    return formatter.string(from: date)
}
