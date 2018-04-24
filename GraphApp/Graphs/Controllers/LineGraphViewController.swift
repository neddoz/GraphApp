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

            var beerDataSet: LineChartDataSet{
                let values = revenueModels.map{ $0.beer }
                var dataEntries: [ChartDataEntry] = []

                for i in 0..<dataPoints.count {
                    let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
                    dataEntries.append(dataEntry)
                }

                let lineChartDataSet = LineChartDataSet(values: dataEntries, label: exciseRevenue.Key.beer)

                return lineChartDataSet
            }

            var cigarettesDataSet: LineChartDataSet{
                let values = revenueModels.map{ $0.cigarettes }
                var dataEntries: [ChartDataEntry] = []

                for i in 0..<dataPoints.count {
                    let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
                    dataEntries.append(dataEntry)
                }

                let lineChartDataSet = LineChartDataSet(values: dataEntries, label: exciseRevenue.Key.cigarettes)

                return lineChartDataSet
            }

            var commoditiesDataSet: LineChartDataSet{
                let values = revenueModels.map{ $0.commodities }
                var dataEntries: [ChartDataEntry] = []

                for i in 0..<dataPoints.count {
                    let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
                    dataEntries.append(dataEntry)
                }

                let lineChartDataSet = LineChartDataSet(values: dataEntries, label: exciseRevenue.Key.commodities)

                return lineChartDataSet
            }

            var spiritsDataSet: LineChartDataSet{
                let values = revenueModels.map{ $0.spirits }
                var dataEntries: [ChartDataEntry] = []

                for i in 0..<dataPoints.count {
                    let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
                    dataEntries.append(dataEntry)
                }

                let lineChartDataSet = LineChartDataSet(values: dataEntries, label: exciseRevenue.Key.spirits)

                return lineChartDataSet
            }

            var totalDataSet: LineChartDataSet{
                let values = revenueModels.map{ $0.total }
                var dataEntries: [ChartDataEntry] = []

                for i in 0..<dataPoints.count {
                    let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
                    dataEntries.append(dataEntry)
                }

                let lineChartDataSet = LineChartDataSet(values: dataEntries, label: exciseRevenue.Key.total)

                return lineChartDataSet
            }

            var watersDataSet: LineChartDataSet{
                let values = revenueModels.map{ $0.waters }
                var dataEntries: [ChartDataEntry] = []

                for i in 0..<dataPoints.count {
                    let dataEntry = ChartDataEntry(x: values[i], y: Double(i))
                    dataEntries.append(dataEntry)
                }

                let lineChartDataSet = LineChartDataSet(values: dataEntries, label: exciseRevenue.Key.waters)

                return lineChartDataSet
            }
            let dataSets = [beerDataSet, cigarettesDataSet, commoditiesDataSet, spiritsDataSet, totalDataSet, watersDataSet]
            setData(dataPoints: dataPoints, dataSets: dataSets)

        case .countyAllocation:
            break
        }
    }

    func setData(dataPoints: [String], dataSets: [LineChartDataSet]) {

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

        let lineChartData = LineChartData(dataSets: dataSets)
        lineChart.data = lineChartData

    }
}
