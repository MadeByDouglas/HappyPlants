//
//  Plant.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import Foundation

struct Plant: Codable {
    var name: String

}

struct Light: Codable {
    var value: Int
    var timestamp: Date
}
