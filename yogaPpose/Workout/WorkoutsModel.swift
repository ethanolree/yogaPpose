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
    
    var posesArray: [String] = [
        "downdog",
        "goddess",
        "tree",
        "plank",
        "warrior"
    ]
    
    var poseNames: [String: String] = [
        "downdog": "Downward Dog",
        "goddess": "Goddess",
        "tree": "Tree",
        "plank": "Plank",
        "warrior": "Warrior"
    ]
    
    /// Gets the workout dictionary for the current user
    lazy var workoutsDict: [String: Workout] = {
        if let data: Data = defaults.object(forKey: "workouts") as? Data {
            let decoder = JSONDecoder()
            let temp = try! decoder.decode([String: Workout].self, from: data)
            return temp
        } else {
            return [
                "workout1": Workout(name: "Workout 1", id: 0, workoutPoses: [
                    setPoseLength(id: "tree", timerLength: 2.0), getWorkoutPoseWithId(id: "goddess")
                ], isSystemWorkout: true),
                "workout2": Workout(name: "Workout 2", id: 1, workoutPoses: [
                    getWorkoutPoseWithId(id: "goddess"), getWorkoutPoseWithId(id: "tree")
                ], isSystemWorkout: true),
                "workout3": Workout(name: "Workout 3", id: 2, workoutPoses: [
                    getWorkoutPoseWithId(id: "warrior"), getWorkoutPoseWithId(id: "plank"), getWorkoutPoseWithId(id: "warrior")
                ], isSystemWorkout: true)
            ]
        }
    }()
    
    lazy var workoutsArray: [String] = {
        return Array(workoutsDict.keys).sorted()
    }()
    
    lazy var recentWorkouts: [String] = {
        if let data: Data = defaults.object(forKey: "recentWorkouts") as? Data {
            let decoder = JSONDecoder()
            let temp = try! decoder.decode([String].self, from: data)
            return temp
        } else {
            return []
        }
    }()
    
    var defaultPoses: [String: WorkoutPose] = [
        "downdog": WorkoutPose(name: "Downward Dog", id: "downdog", length: 10.0, poseImageName: "downdog"),
        "goddess": WorkoutPose(name: "Goddess", id: "goddess", length: 10.0, poseImageName: "goddess"),
        "tree": WorkoutPose(name: "Tree", id: "tree", length: 10.0, poseImageName: "tree"),
        "plank": WorkoutPose(name: "plank", id: "plank", length: 10.0, poseImageName: "plank"),
        "warrior": WorkoutPose(name: "warrior", id: "warrior", length: 10.0, poseImageName: "warrior")
    ]
       
    func setPoseLength(id: String, timerLength: Double) -> WorkoutPose {
        return WorkoutPose(name: poseNames[id] ?? "", id: id, length: timerLength, poseImageName: id)
    }
    
    private func getWorkoutPoseWithId(id: String) -> WorkoutPose {
        return self.defaultPoses[id]!
    }
    
    /// Inserts a new workout
    func addWorkoutToDict(poses: [WorkoutPose]) throws{
        let id: Int = generateWorkoutId()
        let workoutName: String = "Workout \(id)"
        
        workoutsDict["workout\(id)"] = Workout(name: workoutName, id: id, workoutPoses: poses, isSystemWorkout: false)
        workoutsArray = Array(workoutsDict.keys).sorted()
        
        let encoder = JSONEncoder()
        try? defaults.set(encoder.encode(workoutsDict), forKey: "workouts")
        
    }
    
    /// Removes an existing workout
    func removeWorkout(workoutName: String){
        workoutsDict.removeValue(forKey: workoutName)
        workoutsArray = Array(workoutsDict.keys).sorted()
        
        if (recentWorkouts.contains(workoutName)) {
            recentWorkouts.removeAll(where: {$0 == workoutName})
            let encoder = JSONEncoder()
            try? defaults.set(encoder.encode(recentWorkouts), forKey: "recentWorkouts")
        }
        
        let encoder = JSONEncoder()
        try? defaults.set(encoder.encode(workoutsDict), forKey: "workouts")
    }
    
    /// Gets the workout score associated with a workout
    func getWorkoutScore(workoutName: String) -> Double{
        return defaults.double(forKey: workoutName)
    }
    
    /// Adds a workout to recents
    func addWorkoutToRecents(workoutName: String) {
        if (recentWorkouts.contains(workoutName)) {
            recentWorkouts.removeAll(where: {$0 == workoutName})
        }
        
        recentWorkouts.insert(workoutName, at: 0)
        
        /// Remove the oldest workout
        if (recentWorkouts.count > 5) {
            recentWorkouts.removeLast()
        }
        
        let encoder = JSONEncoder()
        try? defaults.set(encoder.encode(recentWorkouts), forKey: "recentWorkouts")
    }
        
    private func generateWorkoutId() -> Int {
        let idMap: [Int] = workoutsDict.map {$1.id}
        return (idMap.max() ?? 0) + 1
    }
}
