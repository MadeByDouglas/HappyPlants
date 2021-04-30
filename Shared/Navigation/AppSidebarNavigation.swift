//
//  AppSidebarNavigation.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI

struct AppSidebarNavigation: View {
    
    @State private var selection: NavigationItem? = .myPlants

    var sidebar: some View {
        List(selection: $selection) {
            NavigationLink(destination: MyPlants().environmentObject(DataManager.shared), tag: NavigationItem.myPlants, selection: $selection) {
                Label(NavigationItem.myPlants.label, systemImage: NavigationItem.myPlants.symbolName)
            }
            .tag(NavigationItem.myPlants)
            
            NavigationLink(destination: Community().environmentObject(DataManager.shared), tag: NavigationItem.community, selection: $selection) {
                Label(NavigationItem.community.label, systemImage: NavigationItem.community.symbolName)
            }
            .tag(NavigationItem.community)
        }
        .listStyle(SidebarListStyle())
    }
    
    var body: some View {
        NavigationView {
            sidebar
            
            Text("No Plants Found")
                .foregroundColor(.secondary)
        }
    }
}

struct AppSidebarNavigation_Previews: PreviewProvider {
    static var previews: some View {
        AppSidebarNavigation()
    }
}
