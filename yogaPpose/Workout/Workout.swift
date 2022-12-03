//
//  Workout.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import Foundation

class Workout {

    /// The name used to identify the workout.
    let name: String
    
    /// List of poses included in the workout
    var workoutPoses: [WorkoutPose]

    /// The time the workout takes
    var length: Double

    init(name: String,
         workoutPoses: [WorkoutPose]) {
        self.name = name
        self.workoutPoses = workoutPoses
        self.length = Workout.getPoseLength(workoutPoses: workoutPoses)
    }
    
    /// Calculates the workout length given the poses
    private static func getPoseLength(workoutPoses: [WorkoutPose]) -> Double {
        var length: Double = 0.0
        
        for pose in workoutPoses {
            length += pose.length
        }
        
        return length
    }
}

