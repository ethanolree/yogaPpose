//
//  StartViewController.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/8/22.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var workoutTitle: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    /// The workout as currently selected by the user
    var workout: Workout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.workoutTitle.text = workout.name
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
