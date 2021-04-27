//
//  Plant.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import Foundation

struct Plant: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var owner: Gardener
    var mood: Mood
    var lightData: Light
    var waterData: Water
    var lastInteraction: Date //when there is large delta in either light or water this date updates with sensor data timestamp
    var lastWatered: Date //when there is large positive delta in water triggers this timestamp
    var imageName: String
}

struct Light: Codable {
    var value: Int
    var timestamp: Date
}

struct Water: Codable {
    var value: Int
    var timestamp: Date
}


enum Mood: String, Codable {
    case happy = "🥳" // recent interaction
    case sad = "🙁" // no interaction for some time
    case chill = "😎" // appropriate light and water
    case scared = "😱" // very low light sensor
    case thirsty = "😥" // low water sensor
    case hot = "🥵" // very high light sensor
    case drunk = "🥴" // very hight water sensor
}
