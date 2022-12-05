//
//  WorkoutsModel.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import UIKit

class WorkoutsModel: NSObject {
    static let sharedInstance = WorkoutsModel()
    
    var workoutsArray: [String] = [
        "workout1",
        "workout2"
    ]
    
    lazy var workoutsDict: [String: Workout] = [
        "workout1": Workout(name: "Workout 1", workoutPoses: [
            getWorkoutPoseWithId(id: "downwardDog"), getWorkoutPoseWithId(id: "goddess")
        ]),
        "workout2": Workout(name: "Workout 2", workoutPoses: [
            getWorkoutPoseWithId(id: "goddess")
        ])
    ]
    
    var poses: [String: WorkoutPose] = [
        "downwardDog": WorkoutPose(name: "Downward Dog", id: "downdog", length: 5.0, poseImageName: "pose1"),
        "goddess": WorkoutPose(name: "Goddess", id: "goddess", length: 5.0, poseImageName: "pose2")
    ]
    
    private func getWorkoutPoseWithId(id: String) -> WorkoutPose {
        return self.poses[id]!
    }
}
