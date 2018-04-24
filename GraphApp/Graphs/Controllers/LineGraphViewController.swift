//
//  LineGraphViewController.swift
//  GraphApp
//
//  Created by kayeli dennis on 24/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit
import Charts

class LineGraphViewController: UIViewController {
    @IBOutlet var lineChart: LineChartView!

    var chartData: [Any]?
    var dataType: NetworkController.APIResource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setChart()
    }

    private func setChart(){
        guard let dataType = dataType else {
            return
        }
        switch dataType{
        case .exciseRevenue:
            guard let revenueModels = chartData as? [exciseRevenue] else {
                return
            }
            var dataPoints: [String]{
                return revenueModels.map {
                    $0.year
                }
            }

            var beerValues: [Double]{
                return revenueModels.map{ $0.beer }
            }

            var cigarettesValues: [Double]{
                return revenueModels.map{ $0.cigarettes }
            }

            setData(dataPoints: dataPoints, values: beerValues, label: "beer")
            setData(dataPoints: dataPoints, values: cigarettesValues, label: "cigarettes")

        case .countyAllocation:
            break
        }
    }

    func setData(dataPoints: [String], values: [Double], label: String) {

        var dataEntries: [ChartDataEntry] = []

        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
            dataEntries.append(dataEntry)
        }

        var colors: [UIColor] = []

        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }

        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: label)
        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        lineChart.data = lineChartData

    }
}
