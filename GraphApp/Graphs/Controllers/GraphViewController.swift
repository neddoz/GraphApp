//
//  GraphViewController.swift
//  GraphApp
//
//  Created by kayeli dennis on 22/04/2018.
//  Copyright © 2018 kayeli dennis. All rights reserved.
//

import UIKit
import then

class GraphViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var lineGraphContainer: UIView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var countySelectionContainer: UIStackView!
    @IBOutlet weak var graphSwitch: UISegmentedControl!
    @IBOutlet weak var lineGraph: UIView!
    @IBOutlet weak var barGraph: UIView!

    var chartData: [JSON]? {
        didSet{
        }
    }
    // Public Instance properties
    var graphReport: ReportType = .exerciseRevenue

    override func viewDidLoad() {
        super.viewDidLoad()


        // Setting up of menu toggling
        setUpMenuSwitch()

        // Bottom border to the county selection container
        addBottomBorder(to: countySelectionContainer)
    }

    // MARK: IBActions

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.performSegue(withIdentifier: AppSegue.toLineGraph.rawValue, sender: nil)
    }
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
    private func modelObjects(`in` list:[JSON], matching type: NetworkController.APIResource)->[Any]?{
        switch type {
        case .exciseRevenue:
            var modelObjects = [exciseRevenue]()
            for item in list{
                if let object = exciseRevenue(json: item){
                    modelObjects.append(object)
                }
            }
            return modelObjects
        case .countyAllocation:
            var modelObjects = [CountyAllocation]()
            for item in list{
                if let object = CountyAllocation(json: item){
                    modelObjects.append(object)
                }
            }
            return modelObjects
        }
    }

    // MARK: Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let endpoint: NetworkController.APIResource = graphReport == .exerciseRevenue ? .exciseRevenue : .countyAllocation

        switch segue.identifier {
        case AppSegue.toLineGraph.rawValue?:
            graphSwitch.selectedSegmentIndex = 1
            guard let destinationVc = segue.destination as? LineGraphViewController else {
                return
            }
            destinationVc.dataType = endpoint
            guard let chartData = chartData else {
                return
            }
            if let models = self.modelObjects(in: chartData, matching: endpoint) {
                destinationVc.chartData = models
            }
        case AppSegue.toBarGraph.rawValue?:
            graphSwitch.selectedSegmentIndex = 0
            guard let destinationVc = segue.destination as? BarGraphViewController else {
                return
            }
            destinationVc.dataType = endpoint
            destinationVc.chartData = chartData
        default:
            break
        }
    }
}

// MARK: Menu Set up and delegates
extension GraphViewController: SWRevealViewControllerDelegate, UIGestureRecognizerDelegate{

}
