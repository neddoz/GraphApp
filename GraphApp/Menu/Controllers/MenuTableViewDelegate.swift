//
//  MenuTableViewDelegate.swift
//  GraphApp
//
//  Created by kayeli dennis on 23/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import Foundation

enum ReportType {
    case exerciseRevenue
    case countyAllocation

    init?(int: Int){
        switch int{
        case 0:
            self = .countyAllocation
        case 1:
            self = .countyAllocation
        default:
            return nil
        }
    }
}

enum AppSegue: String {
    case toGraphsSegue
}

extension MenuTableTableViewController{

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let reportType = ReportType(int: indexPath.row)  else {
            return
        }
        self.performSegue(withIdentifier: AppSegue.toGraphsSegue.rawValue, sender: reportType)
        // TODO: Instantiate view model and pass it to the graph view contoller
    }
}

extension MenuTableTableViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? ReportType,
            let destinationVc = segue.destination as? GraphViewController else {
            return
        }
        destinationVc.graphReport = sender
    }
}
