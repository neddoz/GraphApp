//
//  NetworkController.swift
//  GraphApp
//
//  Created by kayeli dennis on 24/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import Foundation

public enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

class NetworkController {
    static let baseURL = "http://156.0.232.97:8000/"
    enum APIResource: String{
        case exciseRevenue
        case countyAllocation

        var endpoint: String {
            switch self {
            case .exciseRevenue:
                return "\(NetworkController.baseURL)finance/all_excise_revenue"
            case .countyAllocation:
                return "\(NetworkController.baseURL)finance/all_county_allocation"
            }
        }
    }
}

extension NetworkController{
    static func sendGETRequest(_ endpoint: APIResource, completion:@escaping (_ data: Any?)->()){

        guard let requestURL = URL(string:"\(endpoint.endpoint)") else {
            return
        }

        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        let session = URLSession.shared

        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            do{

                guard let unwrappedData = data else { throw JSONError.NoData }

                guard let json = try JSONSerialization.jsonObject(with: unwrappedData, options:JSONSerialization.ReadingOptions.allowFragments) as? NSArray else { throw JSONError.ConversionFailed }
                //print("This is the data: \(json)")
                completion(json)

            } catch let error as JSONError {
                print(error.rawValue)
                completion(nil)

            } catch {
                completion(nil)
                print(error)
            }
        })
        task.resume()
    }
}
