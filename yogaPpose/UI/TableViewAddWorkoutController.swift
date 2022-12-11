//
//  TableViewAddWorkoutController.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/10/22.
//

import UIKit

class TableViewAddWorkoutController: UITableViewController {
    @IBOutlet weak var headingView: UIView!
    
    var workoutBuilder: WorkoutBuilder!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        headingView.isHidden = true

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (workoutBuilder.posesForWorkout.count > 0) {
            headingView.isHidden = false
        }
        
        return workoutBuilder.posesForWorkout.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var dynamicCellId: String
        var cell: UITableViewCell
        
        if (indexPath.row == self.workoutBuilder.posesForWorkout.count) {
            dynamicCellId = "addCell"
            cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath) as! TableViewAddCell
        } else {
            dynamicCellId = "poseCell"
            cell = tableView.dequeueReusableCell(withIdentifier: dynamicCellId, for: indexPath) as! TableViewPoseCell
            (cell as! TableViewPoseCell).workoutBuilder = workoutBuilder
            (cell as! TableViewPoseCell).poseIndex = indexPath.row
            (cell as! TableViewPoseCell).initPose = workoutBuilder.posesForWorkout[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row < workoutBuilder.posesForWorkout.count
    }

    @IBAction func addPoseToWorkout(_ sender: Any) {
        workoutBuilder.addPose()
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    /*
     // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            workoutBuilder.posesForWorkout.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
