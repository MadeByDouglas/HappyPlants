//
//  HappyPlantsAPI.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import Foundation

enum HappyPlantsAPI {
    case gardeners
    case plants
    case demo
}

extension HappyPlantsAPI {
    //TODO: move this to plist and xcode build configs
    var environmentBase: String {
        switch NetworkManager.env {
        case .dev:
            return "https://happy-plants.herokuapp.com/"
        case .prod:
            return "https://happy-plants.herokuapp.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBase) else { fatalError("Base URL not setup properly. You did something wrong.")}
        return url
    }
    
    var username: String? {
        get {
            UserDefaults.standard.string(forKey: UserKeys.username.rawValue)
        }
    }
    
    var path: String {
        switch self {
        case .gardeners: return "gardeners/"
        case .plants: return "plants/"
        case .demo: return "gardener/\(username ?? "")/alfred/light-sensor-data/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .gardeners: return .get
        case .plants: return .get
        case .demo: return .post
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
        case .demo:
            
            
            let sensorData = Light(value: 58, timestamp: Date())
            
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            
            return try! encoder.encode(sensorData)

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
