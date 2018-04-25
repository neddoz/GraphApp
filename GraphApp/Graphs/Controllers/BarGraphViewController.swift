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
            setexciseRevenueBarChart()
        case .countyAllocation:
            setCountyAllocationBarChart()
        }
    }

    private func setData(dataPoints: [String], dataSets: [BarChartDataSet]) {

        var colors: [UIColor] = []

        for _ in 0..<dataSets.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))

            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }

        for (index, set) in dataSets.enumerated(){
            set.setColor(colors[index])
        }

        let lineChartData = BarChartData(dataSets: dataSets)
        barChart.data = lineChartData
    }

    private func setexciseRevenueBarChart(){
        guard let revenueModels = chartData as? [exciseRevenue] else {
            return
        }
        var dataPoints: [String]{
            var arraySet = Set<String>()
            revenueModels.forEach {
                arraySet.insert($0.year)
            }
            var dataPoints = [String]()
            for (_, value) in arraySet.enumerated() {
                dataPoints.append(value)
            }
            return dataPoints
        }

        var beerDataSet: BarChartDataSet{
            let values = revenueModels.map{ $0.beer }
            var dataEntries: [BarChartDataEntry] = []

            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
            }

            let lineChartDataSet = BarChartDataSet(values: dataEntries, label: exciseRevenue.Key.beer)

            return lineChartDataSet
        }

        var cigarettesDataSet: BarChartDataSet{
            let values = revenueModels.map{ $0.beer }
            var dataEntries: [BarChartDataEntry] = []

            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
            }

            let lineChartDataSet = BarChartDataSet(values: dataEntries, label: exciseRevenue.Key.cigarettes)

            return lineChartDataSet
        }

        var commoditiesDataSet: BarChartDataSet{
            let values = revenueModels.map{ $0.beer }
            var dataEntries: [BarChartDataEntry] = []

            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
            }

            let lineChartDataSet = BarChartDataSet(values: dataEntries, label: exciseRevenue.Key.commodities)

            return lineChartDataSet
        }

        var spiritsDataSet: BarChartDataSet{
            let values = revenueModels.map{ $0.beer }
            var dataEntries: [BarChartDataEntry] = []

            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
            }

            let lineChartDataSet = BarChartDataSet(values: dataEntries, label: exciseRevenue.Key.spirits)

            return lineChartDataSet
        }

        var totalDataSet: BarChartDataSet{
            let values = revenueModels.map{ $0.beer }
            var dataEntries: [BarChartDataEntry] = []

            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
            }

            let lineChartDataSet = BarChartDataSet(values: dataEntries, label: exciseRevenue.Key.total)

            return lineChartDataSet
        }

        var watersDataSet: BarChartDataSet{
            let values = revenueModels.map{ $0.beer }
            var dataEntries: [BarChartDataEntry] = []

            for i in 0..<dataPoints.count {
                let dataEntry = BarChartDataEntry(x: values[i], y: Double(i))
                dataEntries.append(dataEntry)
            }

            let lineChartDataSet = BarChartDataSet(values: dataEntries, label: exciseRevenue.Key.waters)

            return lineChartDataSet
        }

        let dataSets = [beerDataSet, cigarettesDataSet, commoditiesDataSet, spiritsDataSet, totalDataSet, watersDataSet]
        setData(dataPoints: dataPoints, dataSets: dataSets)
    }

    private func setCountyAllocationBarChart(){

    }
}
