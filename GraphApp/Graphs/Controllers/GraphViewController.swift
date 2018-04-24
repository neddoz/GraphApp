//
//  GraphViewController.swift
//  GraphApp
//
//  Created by kayeli dennis on 22/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var countySelectionContainer: UIStackView!
    @IBOutlet weak var graphSwitch: UISegmentedControl!
    @IBOutlet weak var lineGraph: UIView!
    @IBOutlet weak var barGraph: UIView!


    // Public Instance properties
    var graphReport: ReportType = .exerciseRevenue {
        didSet{
            fetchReportdata()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up of menu toggling
        setUpMenuSwitch()

        // Bottom border to the county selection container
        addBottomBorder(to: countySelectionContainer)

        let objects = fetchReportdata()
        print("Objects", objects)

    }

    // MARK: IBActions


    @IBAction func graphTypeSwitched(_ sender: UISegmentedControl) {

        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.lineGraph.alpha = 1
                self.barGraph.alpha = 0
            })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.lineGraph.alpha = 0
                self.barGraph.alpha = 1
            })
        }
    }

    // MARK: -Private Instance functions

    private func setUpMenuSwitch() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    private func addBottomBorder(to view: UIView){
        let bottomBorder = CALayer()
        bottomBorder.backgroundColor = UIColor.gray.cgColor
        bottomBorder.frame = CGRect(x: 0.0, y: view.frame.height - 1.0, width: view.frame.width + 2.0, height: 1.0)
        view.layer.addSublayer(bottomBorder)
    }

    private func fetchReportdata()-> NSArray?{
        var dataArrayObjects: NSArray?
        let endpoint: NetworkController.APIResource = graphReport == .exerciseRevenue ? .exciseRevenue : .countyAllocation
        NetworkController.sendGETRequest(endpoint) { data in
            guard let data = data as? NSArray else {
                return
            }
            dataArrayObjects = data
            print("The fetched records are: ", data)
        }
        return dataArrayObjects
    }
}

// MARK: Menu Set up and delegates
extension GraphViewController: SWRevealViewControllerDelegate, UIGestureRecognizerDelegate{

}
