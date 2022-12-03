//
//  WorkoutPose.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import Foundation
import UIKit

class WorkoutPose {    
    /// The name used to identify the pose
    let name: String
    
    /// The time the pose takes
    var length: Double
    
    /// The image associated with a particular pose
    var poseImage: UIImage
    
    init(name: String,
         length: Double,
         poseImageName: String) {
        self.name = name
        self.length = length
        self.poseImage = WorkoutPose.getPoseImage(name: poseImageName)
    }
    
    private static func getPoseImage(name: String) -> UIImage {
        return UIImage(named: name)!
    }
}