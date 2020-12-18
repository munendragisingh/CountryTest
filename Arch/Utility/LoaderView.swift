//
//  LoaderView.swift
//  Arch
//
//  Created by Munendra Pratap Singh on 13/02/20.
//  Copyright © 2020 Munendra Pratap Singh. All rights reserved.
//

import UIKit

/// LoaderView will used to display full screen loader
class LoaderView: UIView {

    let activityIndicatorView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    /// initializer
    /// - Parameter frame: frame of loader
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// layoutSubviews
    override func layoutSubviews() {
        activityIndicatorView.center = self.center
    }
    
    /// set activity Indicator View
    func setup() {
        activityIndicatorView.color = .white
        activityIndicatorView.startAnimating()
        self.addSubview(activityIndicatorView)
    }
}
