//
//  ViewController.swift
//  NFLPredictions
//
//  Created by Amar Bhatia on 8/27/17.
//  Copyright © 2017 AmarBhatia. All rights reserved.
//

import UIKit
import CoreData

class TeamData: NSObject {
    var id: NSNumber?
    var teamName: String?
    var teamProfileImageName: String?
    
}


class DivisionData: NSObject {
    var name: String?
    
    var teams: [TeamData]?
    
}


class StandingsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate, UITextFieldDelegate {
    
    
    private let cellId = "cellId"
    let divisionHeader = "divisionHeader"

    
    var nflDivision = ["NFC North", "NFC East", "NFC South", "NFC West", "AFC North", "AFC East", "AFC South", "AFC West"]
    
    // AFC East
    let afcEast = ["New England Patriots", "Miami Dolphins", "New York Jets", "Buffalo Bills"]
    // AFC North
    let afcNorthDivision = ["Baltimore Ravens", "Cininnati Bengals", "Pittsburgh Steelers", "Cleveland Browns"]
    // AFC South
    let afcSouth = ["Houston Texans", "Jacksonville Jaguars", "Indianapolis Colts", "Tennessee Titans"]
    // AFC West
    let afcWest = ["Kansas City Cheifs", "Denver Broncos", "Oakland Raiders", "Los Angeles Chargers"]
    
    
    // NFC East
    let nfcEast = ["New York Giants", "Philadelphia Eagles", "Washington Redskins", "Dallas Cowboys"]
    // NFC North
    let nfcNorth = ["Minnesota Vikings", "Green Bay Packers", "Detriot Lions", "Chicago Bears"]
    // NFC South
    let nfcSouth = ["Tampa Bay Buccaneers", "New Orleans Saints", "Carolina Panthers", "Atlanta Falcons"]
    // NFC West
    let nfcWest = ["San Francisco 49ers", "Seattle Seahawks", "Arizona Cardinals", "Los Angeles Rams"]
    
    
    
    let afcDivisions = ["AFC North", "AFC East", "AFC South", "AFC West"]
    let nfcDivisions = ["NFC North", "NFC East", "NFC South", "NFC West"]

    
    let nflTeamData: [String] = ["New England Patriots", "Miami Dolphins", "New York Jets", "Buffalo Bills", "Baltimore Ravens", "Cincinnati Bengals", "Pittsburgh Steelers", "Cleveland Browns", "Tampa Bay Buccaneers", "New Orleans Saints", "Carolina Panthers", "Atlanta Falcons", "San Francisco 49ers", "Seattle Seahawks", "Arizona Cardinals", "Los Angeles Rams"]
    
    let nflArray: [String] = ["New England Patriots", "Miami Dolphins", "New York Jets", "Buffalo Bills", "Baltimore Ravens", "Cincinnati Bengals", "Pittsburgh Steelers", "Cleveland Browns", "Houston Texans", "Jacksonville Jaguars", "Indianapolis Colts", "Tennessee Titans", "Kansas City Cheifs", "Denver Broncos", "Oakland Raiders", "Los Angeles Chargers", "New York Giants", "Philadelphia Eagles", "Washington Redskins", "Dallas Cowboys", "Minnesota Vikings", "Green Bay Packers", "Detriot Lions", "Chicago Bears", "Tampa Bay Buccaneers", "New Orleans Saints", "Carolina Panthers", "Atlanta Falcons", "San Francisco 49ers", "Seattle Seahawks", "Arizona Cardinals", "Los Angeles Rams"]

    let nflDictionary: [String: String] = ["New England Patriots" : "1", // AFC East 1
                                           "Miami Dolphins" : "2", // AFC East 2
                                           "New York Jets": "3", // AFC East 3
                                           "Buffalo Bills": "4", // AFC East 4
                                           "Baltimore Ravens": "1", // AFC North 1
                                           "Cincinnati Bengals": "2", // AFC North 2
                                           "Pittsburgh Steelers": "3", // AFC North 3
                                           "Cleveland Browns": "4", // AFC North 4
                                           "Houston Texans": "1", // AFC South 1
                                           "Jacksonville Jaguars" : "2", // AFC South 2
                                           "Indianapolis Colts": "3", // AFC South  3
                                           "Tennessee Titans": "4", // AFC South 4
                                           "Kansas City Cheifs" : "1", // AFC East 1
                                           "Denver Broncos": "2", // AFC East 2
                                           "Oakland Raiders": "3", // AFC East 3
                                           "Los Angeles Chargers": "4", // AFC East 4
                                           "New York Giants": "1",
                                           "Philadelphia Eagles": "2",
                                           "Washington Redskins": "3",
                                           "Dallas Cowboys": "4",
                                           "Minnesota Vikings": "1",
                                           "Green Bay Packers": "2",
                                           "Detriot Lions": "3",
                                           "Chicago Bears": "4",
                                           "Tampa Bay Buccaneers": "1",
                                           "New Orleans Saints": "2",
                                           "Carolina Panthers": "3",
                                           "Atlanta Falcons": "4",
                                           "San Francisco 49ers": "1",
                                           "Seattle Seahawks": "2",
                                           "Arizona Cardinals": "3",
                                           "Los Angeles Rams": "4"
    ]
    
    

    var divisionData: [DivisionData]?
    var teamData: [TeamData]?
    
    func setupData() {
        
        let afcNorthTeamOne = TeamData()
        afcNorthTeamOne.teamName = "New England Patriots"
        afcNorthTeamOne.teamProfileImageName = "Patriots"
        
        let afcNorthTeamTwo = TeamData()
        afcNorthTeamTwo.teamName = "Miami Dolphins"
        afcNorthTeamTwo.teamProfileImageName = "Dolphins"
        
        let afcNorthTeamThree = TeamData()
        afcNorthTeamThree.teamName = "New York Jets"
        afcNorthTeamThree.teamProfileImageName = "Jets"

        let afcNorthTeamFour = TeamData()
        afcNorthTeamFour.teamName = "Buffalo Bills"
        afcNorthTeamFour.teamProfileImageName = "Bills"
        
        let afcNorth = DivisionData()
        afcNorth.name = "AFC North"
        afcNorth.teams = [afcNorthTeamOne, afcNorthTeamTwo, afcNorthTeamThree, afcNorthTeamFour]
        
        
        divisionData = [afcNorth]
        
    }
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<Division> = {
        
        let fetchRequest = NSFetchRequest<Division>()
        let moc = DataManager.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Division", in: moc)
        fetchRequest.entity = entity
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptors = [
            NSSortDescriptor(key: "name", ascending: true),
            ]
        
        fetchRequest.sortDescriptors = sortDescriptors
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                   managedObjectContext: moc,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName:nil)
        aFetchedResultsController.delegate = self
        
        var error: NSError? = nil
        try? aFetchedResultsController.performFetch()
        return aFetchedResultsController
    }()
    
    // Data Source
    var divisions:[Division] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false

        collectionView?.backgroundColor = .white
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: divisionHeader)  // UICollectionReusableView
        collectionView?.register(StandingsCell.self, forCellWithReuseIdentifier: cellId)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(addTapped))
        
        addDummyData()
        divisions = fetchedResultsController.fetchedObjects!

    }
    
    //MARK: CoreData
    func addDummyData() {
        let moc = DataManager.sharedInstance.persistentContainer.viewContext
        
        for div in nflDivision {
            let division = NSEntityDescription.insertNewObject(forEntityName: "Division", into: moc) as! Division
            print(div)
            division.name = div
            addTeams(division: division)
        }
        
        DataManager.sharedInstance.saveContext()
    }
    
    func addTeams(division: Division) {
        let moc = DataManager.sharedInstance.persistentContainer.viewContext

        // Option 1
//        var i = 0
//        while i < 4 {
//            for (key, value) in nflDictionary {
//                print("\(key): \(value)")
//                let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: moc) as! Team
//                let sortedValues = nflDictionary.values.sorted()
//                //                print("Sorted Values:", sortedValues)
//                team.name = "\(key) - \(value)"
//                team.id = Int64(value)!
//                i += 1
//                division.addToTeams(team)
//            }
//            
//        }
        
        // Option 2
        var teams = [[String:Any]]()
        var i = 0
        var team = [String:Any]()
        for (index, teamName) in nflTeamData.enumerated() {
            let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: moc) as! Team
            i = (i % 4) == 0 ? 1 : i + 1
            team.name = "\(teamName) - \(i)"
            print(team.name)
            team.id = Int64(i)
//            team["name"] = "\(teamName) - \(i)"
//            team["id"] = Int64(i)
            division.addToTeams(team)
        }

        // Option 3
//        var i = 1
//        while i < 5 {
//            let team = NSEntityDescription.insertNewObject(forEntityName: "Team", into: moc) as! Team
//            
//            for (index, teamName) in nflTeamData.enumerated() {
//                print(index, teamName)
//            }
//            team.name = "\(nflTeamData[i]) - \(i)"
//            team.id = Int64(i)
//            i += 1
//            division.addToTeams(team)
//        }
    }
    
    //MARK: CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! StandingsCell
        let division = divisions[indexPath.section]
        let team = division.teams?[indexPath.row] as! Team
        cell.teamLabel.text = team.name
        cell.teamLogo.image = #imageLiteral(resourceName: "nfl58")
        cell.winTextField.delegate = self
        cell.lossTextField.delegate = self
        cell.winTextField.tag = 0 //Increment accordingly
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return divisions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let division = divisions[section]
        return division.teams?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let sourceDivision = divisions[sourceIndexPath.section]
        let destinationDivision = divisions[destinationIndexPath.section]
        let teamToMove = sourceDivision.teams?[sourceIndexPath.item] as! Team
        
        sourceDivision.removeFromTeams(at: sourceIndexPath.item)
        destinationDivision.insertIntoTeams(teamToMove, at: destinationIndexPath.item)
        
        DataManager.sharedInstance.saveContext()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // show team info 
        } else {
            // present VC
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, targetIndexPathForMoveFromItemAt originalIndexPath: IndexPath, toProposedIndexPath proposedIndexPath: IndexPath) -> IndexPath {
        if( originalIndexPath.section != proposedIndexPath.section )
        {
            return originalIndexPath
        }
        else
        {
            return proposedIndexPath
        }
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: divisionHeader, for: indexPath) as! Header
            headerView.divisionLabel.text = divisions[indexPath.section].name!
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
    
    
    // MARK: Textfields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            print("Did touch \(touch)")
        }
        
        super.touchesBegan(touches, with: event)

    }

    // MARK: Actions
    
    func addTapped() {
        
    }
    
}


