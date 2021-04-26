//
//  Community.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct Community: View {
    var body: some View {
        Text("All the plants")
        .navigationTitle(NavigationItem.community.label)

    }

}

struct Community_Previews: PreviewProvider {
    static var previews: some View {
        Community()
    }
}
