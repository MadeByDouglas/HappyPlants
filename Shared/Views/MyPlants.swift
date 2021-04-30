//
//  MyPlants.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import SwiftUI
import CoreData

struct MyPlants: View {
    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
    @EnvironmentObject var data: DataManager

    @State var showingLogin = UserDefaults.standard.string(forKey: UserKeys.username.rawValue) == nil
    
    var body: some View {
        List {
            ForEach(data.myPlants) { plant in
                PlantRow(plant: plant)
            }
//            .onDelete(perform: deleteItems)
        }
        .alert(item: $data.createNewPlantResponse) { message in
            Alert(title: Text("Success"), message: Text(message.message), dismissButton: .default(Text("Hooray!")))
        }
        .listStyle(PlainListStyle())
        .navigationTitle(NavigationItem.myPlants.label)
        .sheet(isPresented: $showingLogin) {
            LoginView(isPresented: $showingLogin)
        }
        .toolbar {
            #if os(iOS)
            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                EditButton()
                Button(action: createPlant) {
                    Label("Add Item", systemImage: "plus")
                }
                Button(action: getPlants) {
                    Label("Plants", systemImage: "square.and.arrow.down.on.square")
                }
                Button(action: {
                    showingLogin.toggle()
                }, label: {
                    Label("Account", systemImage: "person.crop.circle")
                })
            }
            #else
            ToolbarItemGroup() {
                Button(action: createPlant) {
                    Label("Add Item", systemImage: "plus")
                }
                Button(action: getPlants) {
                    Label("Plants", systemImage: "square.and.arrow.down.on.square")
                }
                Button(action: {
                    showingLogin.toggle()
                }, label: {
                    Label("Account", systemImage: "person.crop.circle")
                })
            }
            #endif
        }
    }
    
    func createPlant() {
        data.createPlant()
    }
    
    func getPlants() {
        data.getMyPlants()
    }
    
//    let network = NetworkManager()
//
//    func sendLightData() {
//        network.sendData(type: .light)
//    }
//
//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct MyPlants_Previews: PreviewProvider {
    static var previews: some View {
        MyPlants().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
