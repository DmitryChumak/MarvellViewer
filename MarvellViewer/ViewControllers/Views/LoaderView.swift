//
//  LoaderView.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/2/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class LoaderView: UIView {
    
    private let activityView = UIActivityIndicatorView(style: .whiteLarge)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(activityView)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        activityView.startAnimating()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
