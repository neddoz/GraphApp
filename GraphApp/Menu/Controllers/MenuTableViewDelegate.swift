//
//  MenuTableViewDelegate.swift
//  GraphApp
//
//  Created by kayeli dennis on 23/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import Foundation
import then

enum ReportType {
    case exerciseRevenue
    case countyAllocation

    init?(int: Int){
        switch int{
        case 0:
            self = .exerciseRevenue
        case 1:
            self = .countyAllocation
        default:
            return nil
        }
    }
}

enum AppSegue: String {
    case toGraphsSegue
    case toLineGraph
    case toBarGraph
    case allocationToGraphs
    case revenueToGraphs
}

extension MenuTableTableViewController{

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let reportType = ReportType(int: indexPath.row)  else {
            return
        }
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        self.graphReport = reportType
        fetchReportdata().then {[weak self] json in
            self?.chartData = json
            DispatchQueue.global(qos: .userInitiated).async {
                self?.revealViewController().revealToggle(self)
//                self?.performSegue(withIdentifier: AppSegue.toGraphsSegue.rawValue, sender: reportType)
            }
            }.onError { error in
                print(error.localizedDescription)
        }
    }
}

extension MenuTableTableViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppSegue.allocationToGraphs.rawValue || segue.identifier == AppSegue.revenueToGraphs.rawValue {
            guard let nav = segue.destination as? UINavigationController,
                let destinationVc = nav.viewControllers[0] as? GraphViewController else {
                    return
            }
            destinationVc.graphReport = self.graphReport
            destinationVc.chartData = chartData
        }
    }
}
