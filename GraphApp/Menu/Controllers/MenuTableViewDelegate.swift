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
}

extension MenuTableTableViewController{

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let reportType = ReportType(int: indexPath.row)  else {
            return
        }
        self.graphReport = reportType
        fetchReportdata().then {[weak self] json in
            self?.chartData = json
            self?.performSegue(withIdentifier: AppSegue.toGraphsSegue.rawValue, sender: reportType)
            }.onError { error in
                print(error.localizedDescription)
        }
        // TODO: Instantiate view model and pass it to the graph view contoller
    }
}

extension MenuTableTableViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? ReportType,
            let nav = segue.destination as? UINavigationController,
            let destinationVc = nav.viewControllers[0] as? GraphViewController else {
            return
        }
        destinationVc.graphReport = sender
        destinationVc.chartData = chartData
    }
}
