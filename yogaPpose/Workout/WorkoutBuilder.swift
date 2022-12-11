//
//  WorkoutBuilder.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/10/22.
//

import Foundation

class WorkoutBuilder: NSObject {
    var posesForWorkout: [(String, Double)] = []
    var workoutName: String = " "
    var workout: Workout!
    
    lazy private var workoutsModel:WorkoutsModel = {
        return WorkoutsModel.sharedInstance
    }()
    
    func addPose() {
        posesForWorkout.append(("downdog", 10.0))
    }
    
    func setPoseForIndex(index: Int, pose: String) {
        posesForWorkout[index].0 = pose
    }
    
    func setTimeForIndex(index: Int, time: Int) {
        posesForWorkout[index].1 = Double(time)
    }

    
    /// Add workout to dict and userDefaults
    func createWorkout() {
        var workoutPoses: [WorkoutPose] = []
        for pose in posesForWorkout {
            workoutPoses.append(self.workoutsModel.setPoseLength(id: pose.0, timerLength: pose.1))
        }
        
        try? self.workoutsModel.addWorkoutToDict(poses: workoutPoses)
    }    
}
