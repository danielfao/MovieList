//
//  BaseView.swift
//  MovieList
//
//  Created by Daniel Oliveira on 07/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class BaseView: UIView {
    //MARK: - Initialization Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}
