//
//  Workout.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import Foundation

class Workout: Codable {

    /// The name used to identify the workout.
    let name: String
    
    /// Integer ID tied to a workout
    let id: Int
    
    /// List of poses included in the workout
    var workoutPoses: [WorkoutPose]

    /// The time the workout takes
    var length: Double
    
    /// Defines weather the workout is a system workout or not
    var isSystemWorkout: Bool

    init(name: String,
         id: Int,
         workoutPoses: [WorkoutPose],
         isSystemWorkout: Bool) {
        self.name = name
        self.id = id
        self.workoutPoses = workoutPoses
        self.isSystemWorkout = isSystemWorkout
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

