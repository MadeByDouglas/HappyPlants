//
//  HappyPlantsAPI.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import Foundation

enum HappyPlantsAPI {
    case allPlants
    case myPlants
    case addPlant
}

extension HappyPlantsAPI {
    //TODO: move this to plist and xcode build configs
    var environmentBase: String {
        switch NetworkManager.env {
        case .dev:
            return "http://http://localhost:8080"
        case .prod:
            return "https://happy-plants.herokuapp.com"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBase) else { fatalError("Base URL not setup properly. You did something wrong.")}
        return url
    }
    
    var username: String? {
        UserDefaults.standard.string(forKey: UserKeys.username.rawValue)
    }
    
    var path: String {
        switch self {
        case .allPlants: return "/plants"
        case .myPlants: return "/gardener/\(username ?? "")/plants"
        case .addPlant: return "/gardener/\(username ?? "")/add-plant"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .allPlants: return .get
        case .myPlants: return .get
        case .addPlant: return .post
        }
    }
    
    public var sampleData: Data {
      return Data()
    }
    
    public var body: Data? {
        //TODO: add cases where you want to add a http body to a request
        
        //see about encoding JSON
//        body = try JSONEncoder().encode(data)
        
        switch self {
        case .addPlant:
            
            guard let username = username else {return nil}
            let images = ["plant1", "plant2"]
            let randomImage = images.randomElement()!
            
            let newPlant = Plant(name: "George", owner: Gardener(name: username, bio: "A real plant person"), mood: .chill, lightData: Light(value: 0, timestamp: Date()), waterData: Water(value: 0, timestamp: Date()), lastInteraction: Date(), lastWatered: Date(), imageName: randomImage)

            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            
            return try! encoder.encode(newPlant)

        default:
            return nil
        }
    }
    
    public var task: String {
        //TODO: not sure how to make this work with alamofire since request tasks are not enums
        return ""

    }
    
    func request(completion: @escaping DataTaskCompletion) {
        let url = baseURL.appendingPathComponent(path)
        
        var req = URLRequest(url: url)
        req.httpMethod = method.rawValue
        req.timeoutInterval = 7
        req.allHTTPHeaderFields = headers
        req.httpBody = body
        
        let task = URLSession.shared.dataTask(with: req) { (result) in
            completion(result)
        }
        task.resume()
    }

    public var headers: [String: String]? {
        let headers = ["Content-Type": "application/json", "Accept": "application/json"]
        return headers
    }


}

struct SWAPIResponse<T: Codable>: Codable {
    var count: Int
    var next: URL?
    var previous: URL?
    var results: [T]

}
