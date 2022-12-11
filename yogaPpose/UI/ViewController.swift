//
//  ViewController.swift
//  yogaPpose
//
//  Created by Ethan Olree on 11/29/22.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var workoutResultsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        workoutResultsCollectionView.delegate = self
        workoutResultsCollectionView.dataSource = self
    }
    
    lazy private var workoutsModel:WorkoutsModel = {
        return WorkoutsModel.sharedInstance
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.workoutsModel.workoutsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dynamicCellId = "recentCell"
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dynamicCellId, for: indexPath) as? CollectionViewCell {
            cell.workoutName.text = workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]?.name
            cell.workoutScore.text = String(workoutsModel.getWorkoutScore(workoutName: workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]?.name ?? ""))
            return cell
        } else {
            fatalError("Could not dequeue cell")
        }
    }

    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dynamicCellId: String
        
        dynamicCellId = "scoreCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath) as! TableViewScoreCell
        cell.workout1 = workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]
        cell.score = workoutsModel.getWorkoutScore(workoutName: workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]!.name)
        

        return cell
    }*/

}

