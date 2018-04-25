//
//  BarGraphViewController.swift
//  GraphApp
//
//  Created by kayeli dennis on 24/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit
import Charts

class BarGraphViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var barChart: BarChartView!

    // MARK: Public Instance properties
    var chartData: [JSON]?
    var dataType: NetworkController.APIResource?

    override func viewDidLoad() {
        super.viewDidLoad()
        setChart()
    }

    func setChart(){

    }
}
