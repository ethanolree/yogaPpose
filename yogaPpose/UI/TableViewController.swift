//
//  TableViewController.swift
//  SinkOrSwim
//
//  Created by Ethan Olree on 9/11/22.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy private var workoutsModel:WorkoutsModel = {
        return WorkoutsModel.sharedInstance
    }()
    
    private var workoutBuilder: WorkoutBuilder!

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutsModel.workoutsArray.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dynamicCellId: String
        var cell: UITableViewCell
        
        if (indexPath.row == self.workoutsModel.workoutsArray.count) {
            dynamicCellId = "addCell"
            cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath) as! TableViewAddCell
        } else {
            dynamicCellId = "basicCell"
            cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath) as! TableViewCell
            (cell as! TableViewCell).workout = workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]
        }

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support determining if a row is editable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < self.workoutsModel.workoutsArray.count
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let viewController = segue.destination as? PoseViewController,
           let cell = sender as? TableViewCell,
           let workout = cell.workout {
                viewController.workout = workout
            }
        
        if let viewController = segue.destination as? TableViewAddWorkoutController {
            workoutBuilder = WorkoutBuilder()
            viewController.workoutBuilder = workoutBuilder
        }
    }
    
    @IBAction func cancelWorkout(segue: UIStoryboardSegue) {
        print("Workout Canceled")
    }
    
    @IBAction func refreshTable(segue: UIStoryboardSegue) {
        print("REFRESH TABLE")
        workoutBuilder.createWorkout()
        /// Delay table refresh
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print("AQUI")
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }

}
