//
//  Community.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct Community: View {
    
    @EnvironmentObject var data: DataManager


    var body: some View {
        List {
            ForEach(data.allPlants) { plant in
                PlantRow(plant: plant)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle(NavigationItem.community.label)
        .toolbar {
            #if os(iOS)
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: getPlants) {
                    Label("Plants", systemImage: "square.and.arrow.down.on.square")
                }
            }
            #else
            ToolbarItemGroup() {
                Button(action: getPlants) {
                    Label("Plants", systemImage: "square.and.arrow.down.on.square")
                }
            }
            #endif
        }

    }
    
    func getPlants() {
        data.getAllPlants()
    }

}

struct Community_Previews: PreviewProvider {
    static var previews: some View {
        Community()
    }
}
