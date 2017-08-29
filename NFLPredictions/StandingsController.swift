//
//  ViewController.swift
//  NFLPredictions
//
//  Created by Amar Bhatia on 8/27/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import UIKit
import CoreData

class StandingsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    let divisionHeader = "divisionHeader"

    var afcDivisions = ["AFC North", "AFC East", "AFC South", "AFC West"]
    var nfcDivisions = ["NFC North", "NFC East", "NFC South", "NFC West"]
    

    
    var numbers: [Int] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...32 {
            numbers.append(i)
        }
        
        self.clearsSelectionOnViewWillAppear = false

        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: divisionHeader)  // UICollectionReusableView
        collectionView?.register(StandingsCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(addTapped))

        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StandingsCell
        cell.teamLabel.text = "\(numbers[indexPath.item])"
        return cell
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let temp = numbers.remove(at: sourceIndexPath.item)
        numbers.insert(temp, at: destinationIndexPath.item)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: divisionHeader, for: indexPath) as! Header
            headerView.divisionLabel.text = nfcDivisions[indexPath.item]
            return headerView
        } else {
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func addTapped() {
        
    }

}

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

