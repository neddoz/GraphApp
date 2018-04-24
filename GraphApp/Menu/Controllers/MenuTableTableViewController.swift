//
//  MenuTableTableViewController.swift
//  GraphApp
//
//  Created by kayeli dennis on 22/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit
import then

class MenuTableTableViewController: UITableViewController {


    // Public Instance properties
    var chartData: [JSON]?
    var graphReport: ReportType = .exerciseRevenue {
        didSet{
            fetchReportdata().then {[weak self] json in
                self?.chartData = json
                }.onError { error in
                    print(error.localizedDescription)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    func fetchReportdata()-> Promise<[JSON]?>{
        return Promise { resolve, reject in
            let endpoint: NetworkController.APIResource = self.graphReport == .exerciseRevenue ? .exciseRevenue : .countyAllocation
            NetworkController.sendGETRequest(endpoint) { data in
                if let dataObjects = data as? [JSON] {
                    resolve(dataObjects)
                }else {
                    return reject("Unable to fetch data" as! Error)
                }
            }
        }
    }
}
