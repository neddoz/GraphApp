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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up of menu toggling
        setUpMenuSwitch()
    }

    // MARK: -Private Instance functions

    private func setUpMenuSwitch() {
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}

// MARK: Menu Set up and delegates
extension GraphViewController: SWRevealViewControllerDelegate, UIGestureRecognizerDelegate{

}
