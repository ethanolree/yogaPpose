//
//  customWorkoutViewController.swift
//  yogaPpose
//
//  Created by Alex Gregory on 12/9/22.
//
import UIKit

class customWorkoutViewController: UITableViewController {
    
    private var posesForWorkout: [String: Double] = [:]
    private var workoutName: String = " "
    var workout: Workout!
    
    lazy private var workoutsModel:WorkoutsModel = {
        return WorkoutsModel.sharedInstance
    }()

    
    //Add workout to dict and userDefaults
    private func createWorkout() {
        for (key, value) in posesForWorkout {
            workout.workoutPoses.append(self.workoutsModel.setPoseLength(id: key, timerLength: value))
        }
        
        self.workoutsModel.addWorkoutToDict(workoutName: workoutName, newWorkout: workout)
    }
    
    private func removeWorkout(workoutToBeRemoved: String) {
        self.workoutsModel.removeWorkoutDict(workoutName: workoutToBeRemoved)
    }
    
    
}
