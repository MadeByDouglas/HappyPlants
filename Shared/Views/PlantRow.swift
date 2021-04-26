//
//  PlantRow.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct PlantRow: View {
    var plant: Plant
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(plant.imageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 24.0))
                .frame(width: 100, height: 100, alignment: .center)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack() {
                    Text(plant.name)
                        .font(.title)
                    Spacer()
                    Text(plant.mood.rawValue)
                        .font(.system(size: 36))
                }
                Text("Proudly owned by: " + plant.owner.name)
                    .font(.caption)
                Text("Last played with: " + displayDate(plant.lastInteraction))
                    .font(.caption2)
                Text("Last watered: " + displayDate(plant.lastWatered))
                    .font(.caption2)
            }

        }
    }
}

struct PlantRow_Previews: PreviewProvider {
    static var previews: some View {
        PlantRow(plant: Plant(id: 0, name: "George", owner: Gardener(name: "Yoshi", bio: "A real plant person"), mood: .chill, lightData: Light(value: 54, timestamp: Date()), waterData: Water(value: 65, timestamp: Date()), lastInteraction: Date(), lastWatered: Date(), imageName: "plant1"))
    }
}
