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
        return self.workoutsModel.recentWorkouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dynamicCellId = "recentCell"
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dynamicCellId, for: indexPath) as? CollectionViewCell {
            cell.workoutName.text = workoutsModel.workoutsDict[workoutsModel.recentWorkouts[indexPath.row]]?.name
            cell.workoutScore.text = String(workoutsModel.getWorkoutScore(workoutName: workoutsModel.workoutsDict[workoutsModel.recentWorkouts[indexPath.row]]?.name ?? ""))
            return cell
        } else {
            fatalError("Could not dequeue cell")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.workoutResultsCollectionView.reloadData()
        self.workoutResultsCollectionView.refreshControl?.endRefreshing()
    }
}

