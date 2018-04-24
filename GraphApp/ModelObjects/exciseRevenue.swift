//
//  exciseRevenue.swift
//  GraphApp
//
//  Created by kayeli dennis on 24/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

struct exciseRevenue {
    struct Key {
        static let year = "year"
        static let beer = "beer"
        static let cigarettes = "cigarettes"
        static let waters = "waters"
        static let spirits = "spirits"
        static let commodities = "commodities"
        static let total = "total"
    }

    let year: String
    let beer: Double
    let cigarettes: Double
    let waters: Double
    let spirits: Double
    let commodities: Double
    let total: Double

    init?(json: JSON) {
        guard let year = json[Key.year] as? String,
            let beer = json[Key.beer] as? Double,
            let cigarettes = json[Key.cigarettes] as? Double,
            let waters = json[Key.waters] as? Double,
            let spirits = json[Key.spirits] as? Double,
            let commodities = json[Key.commodities] as? Double,
            let total = json[Key.total] as? Double else {
            return nil
        }

        self.year = year
        self.beer = beer
        self.cigarettes = cigarettes
        self.waters = waters
        self.spirits = spirits
        self.commodities = commodities
        self.total = total
    }
}
