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


let dummyData: [Plant] = [Plant(name: "George", owner: Gardener(name: "Douglas Hewitt", bio: "A real plant person"), mood: .chill, lightData: Light(value: 54, timestamp: Date()), waterData: Water(value: 65, timestamp: Date()), lastInteraction: Date(), lastWatered: Date(), imageName: "plant1"), Plant(name: "Roy", owner: Gardener(name: "Francesca", bio: "A real plant person"), mood: .happy, lightData: Light(value: 54, timestamp: Date()), waterData: Water(value: 65, timestamp: Date()), lastInteraction: Date(), lastWatered: Date(), imageName: "plant2")]
