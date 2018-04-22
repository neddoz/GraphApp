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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Toggle Switch position
        toggleSwitchPosition()
    }

    // MARK: -Private Instance functions

    private func setUpMenuSwitch() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }

    private func toggleSwitchPosition() {
        if countySelectionContainer.isHidden {
            countySelectionContainer.translatesAutoresizingMaskIntoConstraints = false
            graphSwitch.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100.0)
        }else {
            countySelectionContainer.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

// MARK: Menu Set up and delegates
extension GraphViewController: SWRevealViewControllerDelegate, UIGestureRecognizerDelegate{

}
