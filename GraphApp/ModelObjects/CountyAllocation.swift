//
//  CountyAllocation.swift
//  GraphApp
//
//  Created by kayeli dennis on 24/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import Foundation

struct CountyAllocation{
    struct Key{
        static let county = "county"
        static let recurrent = "recurrent"
        static let development = "development"
        static let total = "total"
        static let year = "year"
    }

    let county: String
    let recurrent: Double
    let development: Double
    let total: Double
    let year: String

    init?(json: JSON){
        guard let county = json[Key.county] as? String,
            let recurrent = Double(json[Key.recurrent] as? String ?? ""),
            let development = Double(json[Key.development]as? String ?? ""),
            let total = Double(json[Key.total] as? String ?? ""),
            let year = json[Key.year] as? String else {
            return nil
        }

        self.county = county
        self.recurrent = recurrent
        self.development = development
        self.total = total
        self.year = year
    }
}
