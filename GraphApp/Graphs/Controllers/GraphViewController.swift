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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up of menu toggling
        setUpMenuSwitch()

        // Bottom border to the county selection container
        addBottomBorder(to: countySelectionContainer)
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
}

// MARK: Menu Set up and delegates
extension GraphViewController: SWRevealViewControllerDelegate, UIGestureRecognizerDelegate{

}
