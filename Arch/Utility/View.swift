//
//  View.swift
//  Arch
//
//  Created by Munendra Singh on 17/12/20.
//

import UIKit

protocol ViewDelegate: class {
    func view(view: View, didPerformAction action: Any, userInfo: Any?)
}

class View: UIView {
    
    weak var delegate: ViewDelegate?
    fileprivate var loaderView = UIView()
    
    func viewDidLoad() {
        
    }
    
    override func layoutSubviews() {
        loaderView = LoaderView(frame: Utility.main.window?.frame ?? self.frame)
    }
    
    func viewWillAppear() {
    }
    
    func viewDidAppear() {
    }
    
    func viewWillDisappear() {
    }
    
    func viewDidDisappear() {
    }
}

extension View {
     func showLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else{
                return
            }
            Utility.main.window?.addSubview(self.loaderView)
        }
    }

    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else {
                return
            }
            self.loaderView.removeFromSuperview()
        }
    }
}
