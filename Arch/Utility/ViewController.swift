//
//  ViewController.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var _view: View?
    
    //MARK: - Controller Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _view = self.view as? View
        _view?.delegate = self
        _view?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        _view?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _view?.viewDidAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        _view?.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        _view?.viewDidDisappear()
    }
    
}

extension ViewController {
    /// display alert
    /// - Parameters:
    ///   - title: title of alert
    ///   - message: alert message 
    func showAlert(title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
        }))
        self.present(alertView, animated: true, completion: nil)
    }
}



extension ViewController: ViewDelegate {
   @objc func view(view: View, didPerformAction action: Any, userInfo: Any?) {
    }
}
