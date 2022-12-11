//
//  TableViewScoreCell.swift
//  yogaPpose
//
//  Created by Alex Gregory on 12/11/22.
//

import UIKit

class TableViewScoreCell: UITableViewCell{
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var workoutScore: UILabel!
    
    var workout1: Workout? {
        didSet{
//            workoutName.text = workout1?.name
//            workoutName.text = "hi"
        }
    }
    
    var score: Double? {
        didSet{
//            workoutScore.text = score
        }
    }
    
}
