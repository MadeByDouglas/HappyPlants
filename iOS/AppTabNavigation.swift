//
//  AppTabNavigation.swift
//  HappyPlants (iOS)
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct AppTabNavigation: View {
    
    @State private var selection: NavigationItem = .myPlants

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                MyPlants().environmentObject(DataManager.shared)
            }
            .tabItem {
                Label(NavigationItem.myPlants.label, systemImage: NavigationItem.myPlants.symbolName)
                    .accessibility(label: Text(NavigationItem.myPlants.label))
            }
            .tag(NavigationItem.myPlants)
            
            NavigationView {
                Community().environmentObject(DataManager.shared)
            }
            .tabItem {
                Label(NavigationItem.community.label, systemImage: NavigationItem.community.symbolName)
                    .accessibility(label: Text(NavigationItem.community.label))
            }
            .tag(NavigationItem.community)
        }
    }
}

struct AppTabNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppTabNavigation()
    }
}
