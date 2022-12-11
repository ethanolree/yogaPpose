//
//  ViewController.swift
//  yogaPpose
//
//  Created by Ethan Olree on 11/29/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var workoutResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        workoutResultsTableView.delegate = self
        workoutResultsTableView.dataSource = self
        workoutResultsTableView.register(TableViewScoreCell.self, forCellReuseIdentifier: "scoreCell")
    }
    
    lazy private var workoutsModel:WorkoutsModel = {
        return WorkoutsModel.sharedInstance
    }()

    func numberOfSections(in workoutResultsTableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutsModel.workoutsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dynamicCellId: String
        
        dynamicCellId = "scoreCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath) as! TableViewScoreCell
        cell.workout1 = workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]
        cell.score = workoutsModel.getWorkoutScore(workoutName: workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]!.name)
        

        return cell
    }

}

