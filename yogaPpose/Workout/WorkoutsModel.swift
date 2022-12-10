//
//  WorkoutsModel.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import UIKit

class WorkoutsModel: NSObject {
    static let sharedInstance = WorkoutsModel()
    let defaults = UserDefaults.standard
    
    
    var workoutsArray: [String] = [
        "workout1",
        "workout2",
        "workout3"
    ]
    
    lazy var workoutsDict: [String: Workout] = [
        "workout1": Workout(name: "Workout 1", workoutPoses: [
            setPoseLength(id: "downwardDog", timerLength: 2.0), getWorkoutPoseWithId(id: "goddess")
        ]),
        "workout2": Workout(name: "Workout 2", workoutPoses: [
            getWorkoutPoseWithId(id: "goddess"), getWorkoutPoseWithId(id: "tree")
        ]),
        "workout3": Workout(name: "Workout 3", workoutPoses: [
            getWorkoutPoseWithId(id: "warrior"), getWorkoutPoseWithId(id: "plank"), getWorkoutPoseWithId(id: "warrior")
        ])
    ]
    
    var poses: [String: WorkoutPose] = [
        "downwardDog": WorkoutPose(name: "Downward Dog", id: "downdog", length: 10.0, poseImageName: "downdog"),
        "goddess": WorkoutPose(name: "Goddess", id: "goddess", length: 10.0, poseImageName: "goddess"),
        "tree": WorkoutPose(name: "Tree", id: "tree", length: 10.0, poseImageName: "tree"),
        "plank": WorkoutPose(name: "plank", id: "plank", length: 10.0, poseImageName: "plank"),
        "warrior": WorkoutPose(name: "warrior", id: "warrior", length: 10.0, poseImageName: "warrior")
    ]
    
    
    private func initWorkoutPoses(){
        if defaults.object(forKey: "Workouts") == nil{
            defaults.set(workoutsDict, forKey: "Workouts")
            print("inits")
        } else {
            defaults.set(workoutsDict, forKey: "Workouts")
            workoutsDict = defaults.object(forKey: "Workouts") as? [String: Workout] ?? [String: Workout]()
        }
        
    }
       
    func setPoseLength(id: String, timerLength: Double) -> WorkoutPose {
        var tempPose = self.poses[id]
        tempPose?.length = timerLength
        return tempPose!
    }
    
    private func getWorkoutPoseWithId(id: String) -> WorkoutPose {
        return self.poses[id]!
    }
    
    func addWorkoutToDict(workoutName: String, newWorkout: Workout){
        workoutsDict = defaults.object(forKey: "Workouts") as? [String: Workout] ?? [String: Workout]()
        workoutsDict[workoutName] = newWorkout
        defaults.set(workoutsDict, forKey: "Workouts")
    }
    
    func removeWorkoutDict(workoutName: String){
        workoutsDict = defaults.object(forKey: "Workouts") as? [String: Workout] ?? [String: Workout]()
        workoutsDict.removeValue(forKey: workoutName)
        defaults.set(workoutsDict, forKey: "Workouts")
    }
        
    
    
}
