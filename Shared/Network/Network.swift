//
//  Network.swift
//  HappyPlants
//
//  Created by Douglas Hewitt on 4/25/21.
//

import Foundation

typealias DataTaskResult = Swift.Result<(URLResponse, Data), Error>
typealias DataTaskCompletion = (DataTaskResult) -> Void

typealias GardenersResult = Swift.Result<Gardener, Error>
typealias GardenersCompletion = (GardenersResult) -> Void


enum NetworkError: String, Error {
    case badToken = "invalid token"
    case unknown = "unknown"
    case badURL = "badURL"
    case decodingError = "decodingError"
}

enum NetworkEnvironment {
    case dev
    case prod
}

enum SensorData {
    case light
    case water
}

struct NetworkManager {
    static let env = NetworkEnvironment.dev
    
    let decoder = JSONDecoder()
    
    func addPlant() {
        let api = HappyPlantsAPI.addPlant
        api.request { (result) in
            switch result {
            case .success(let response, let data):
                print(response.description)
                
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                print(dataString!)

            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAllPeople(completion: @escaping GardenersCompletion) {
        let api = HappyPlantsAPI.allPlants
        
        api.request { (result) in
            switch result {
            case .success(let response, let data):
                print(response.description)
                
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                print(dataString!)
                
                let decoder = JSONDecoder()

                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)

                    let formatter = DateFormatter.SWAPIFormatter
                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                    let formatter2 = DateFormatter.SWAPIFormatterReleaseDate
                    if let date = formatter2.date(from: dateStr) {
                        return date
                    }
                    throw DateError.invalidDate
                })
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let people = try! decoder.decode(Gardener.self, from: data)
                
                completion(.success(people))
                
            case .failure(let error):
                print(error)
                
                completion(.failure(error))
            }
        }
    }
}


extension URLSession {
    func dataTask(with url: URL, result: @escaping DataTaskCompletion) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
    
    func dataTask(with request: URLRequest, result: @escaping DataTaskCompletion) -> URLSessionDataTask {
        return dataTask(with: request) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}

enum DateError: String, Error {
    case invalidDate
}

extension DateFormatter {
    static let SWAPIFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
    }()
    
    static let SWAPIFormatterReleaseDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}


public enum HTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
