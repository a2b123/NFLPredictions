//
//  StandingsCell.swift
//  NFLPredictions
//
//  Created by Amar Bhatia on 8/27/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import UIKit

class StandingsCell: BaseCell {
    
    let teamLogo: UIImageView = {
        let iv = UIImageView()
        //        iv.image = #imageLiteral(resourceName: "nfl58")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.backgroundColor = .green
        return iv
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        //        label.backgroundColor = .yellow
        label.text = "Team"
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .red
        
        addSubview(teamLabel)
        addSubview(teamLogo)
        
        addConstraintsWithFormat(format: "H:|-14-[v0(44)]-10-[v1]|", views: teamLogo, teamLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: teamLabel)
        addConstraintsWithFormat(format: "V:[v0(44)]", views: teamLogo)
        
        addConstraint(NSLayoutConstraint(item: teamLogo, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: teamLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
