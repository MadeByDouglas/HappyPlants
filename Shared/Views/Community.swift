//
//  Community.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct Community: View {
    let plants: [Plant] = dummyData

    var body: some View {
        List {
            ForEach(plants) { plant in
                PlantRow(plant: plant)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle(NavigationItem.community.label)

    }

}

struct Community_Previews: PreviewProvider {
    static var previews: some View {
        Community()
    }
}
