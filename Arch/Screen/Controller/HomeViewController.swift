//
//  ViewController.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit


class HomeViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func view(view: View, didPerformAction action: Any, userInfo: Any?) {
        switch action {
        case HomeViewAction.showAlert:
            self.showAlert(title: "error", message: (userInfo as? String) ?? "")
        default: break
            
        }
    }
}

