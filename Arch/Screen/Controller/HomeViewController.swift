//
//  ViewController.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit


class HomeViewController: ViewController {
    
    override func viewDidLoad() {
        self.view = HomeView()
        super.viewDidLoad()
    }
    
    /// this methos will handle all events comming from view
    /// - Parameters:
    ///   - view: view
    ///   - action: event
    ///   - userInfo: data comming from view
    override func view(view: View, didPerformAction action: Any, userInfo: Any?) {
        switch action {
        case HomeViewAction.showAlert:
            self.showAlert(title: "error", message: (userInfo as? String) ?? "")
        case HomeViewAction.setTitle:
            self.title = (userInfo as? String) ?? "Title"
        default: break
            
        }
    }
}

