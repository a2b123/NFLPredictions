//
//  HeaderCell.swift
//  NFLPredictions
//
//  Created by Amar Bhatia on 8/31/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import UIKit

class Header: UICollectionReusableView {
    
    var divisionLabel: UILabel = {
        let label = UILabel()
        label.text = "Division"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        
        addSubview(divisionLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: divisionLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: divisionLabel)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

