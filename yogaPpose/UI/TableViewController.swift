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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutsModel.workoutsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dynamicCellId = "basicCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath) as! TableViewCell

        cell.workout = workoutsModel.workoutsDict[workoutsModel.workoutsArray[indexPath.row]]

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
    }
    
    @IBAction func cancelWorkout(segue: UIStoryboardSegue) {
        print("Workout Canceled")
    }

}
