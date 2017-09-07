//
//  StandingsCell.swift
//  NFLPredictions
//
//  Created by Amar Bhatia on 8/27/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import UIKit

class StandingsCell: BaseCell, UITextFieldDelegate {
    
    let teamLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "nfl58")
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 24
        iv.backgroundColor = .white
        return iv
    }()
    
    let teamLabel: UILabel = {
        let label = UILabel()
        label.text = "Team"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    let winTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "W"
        tf.textColor = .white
        tf.setBottomBorder()
        tf.keyboardType = .numberPad
        tf.returnKeyType = .done
        tf.textAlignment = .center
        tf.backgroundColor = .red
        tf.addTarget(self, action: #selector(validateRecord), for: .touchUpInside)
        return tf
    }()

    let lossTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "L"
        tf.textColor = .white
        tf.setBottomBorder()
        tf.keyboardType = .numberPad
        tf.returnKeyType = .done
        tf.textAlignment = .center
        tf.backgroundColor = .red
        tf.addTarget(self, action: #selector(validateRecord), for: .touchUpInside)
        return tf
    }()

    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .red
        
        addSubview(teamLabel)
        addSubview(teamLogo)
        
        let teamRecordStackView = UIStackView(arrangedSubviews: [winTextField, lossTextField])
        teamRecordStackView.distribution = .fillEqually
        teamRecordStackView.axis = .horizontal
        teamRecordStackView.spacing = 10
        addSubview(teamRecordStackView)
        
        addConstraintsWithFormat(format: "H:|-14-[v0(48)]-10-[v1]-10-[v2(120)]-10-|", views: teamLogo, teamLabel, teamRecordStackView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: teamLabel)
        addConstraintsWithFormat(format: "V:[v0(48)]", views: teamLogo)
        addConstraintsWithFormat(format: "V:[v0(30)]", views: teamRecordStackView)
        
        addConstraint(NSLayoutConstraint(item: teamLogo, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: teamLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: teamRecordStackView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
    
    func validateRecord() {
        
    }
}
