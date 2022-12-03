//
//  WorkoutsModel.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import UIKit

class WorkoutsModel: NSObject {
    static let sharedInstance = WorkoutsModel()
    
    var workouts: [Workout] = [
        Workout(name: "workout1", workoutPoses: [WorkoutPose(name: "pose1", length: 5.0, poseImageName: "pose1"), WorkoutPose(name: "pose2", length: 5.0, poseImageName: "pose2")]),
        Workout(name: "workout2", workoutPoses: [WorkoutPose(name: "pose1", length: 5.0, poseImageName: "pose2")])
    ]
}
