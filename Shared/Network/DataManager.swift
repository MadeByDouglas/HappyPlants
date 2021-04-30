//
//  DataManager.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/29/21.
//

import CoreData
import SwiftUI

class DataManager: NSObject, ObservableObject {
    static var shared = DataManager()
    
    @Published var myPlants: [Plant] = []
    @Published var allPlants: [Plant] = []


    
    
    let network = NetworkManager()
    
    func createPlant() {
        network.addPlant()
    }
    
    func getAllPlants() {
        network.getAllPlants { result in
            switch result {
            case .success(let plants):
                DispatchQueue.main.async {
                    self.allPlants = plants
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMyPlants() {
        network.getMyPlants { result in
            switch result {
            case .success(let plants):
                DispatchQueue.main.async {
                    self.myPlants = plants
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    // we're not using core data but we might in the future
    
//    func savePeopleFromServer(viewContext: NSManagedObjectContext) {
//        network.getAllPeople { (result) in
//            switch result {
//            case .success(let people):
//
//                //TODO: check for existing items in core data and only update as necessary.
//
//                for person in people.results {
//                    CoreDataPerson.create(in: viewContext, person: person)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}
