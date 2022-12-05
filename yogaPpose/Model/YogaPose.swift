//
//  YogaPose.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/4/22.
//

import CoreML
import Foundation

class YogaPose {
    private let poseNetMLModel: MLModel

    init() {
        poseNetMLModel = try! yogapose(configuration: .init()).model
    }
    
    func predict(_ pose: Pose) -> String {
        let input = yogaposeInput(
            noseX: Double(pose.joints[.nose]?.position.x ?? 0.0),
            noseY: Double(pose.joints[.nose]?.position.y ?? 0.0),
            leftEyeX: Double(pose.joints[.leftEye]?.position.x ?? 0.0),
            leftEyeY: Double(pose.joints[.leftEye]?.position.y ?? 0.0),
            leftEarX: Double(pose.joints[.leftEar]?.position.x ?? 0.0),
            leftEarY: Double(pose.joints[.leftEar]?.position.y ?? 0.0),
            leftShoulderX: Double(pose.joints[.leftShoulder]?.position.x ?? 0.0),
            leftShoulderY: Double(pose.joints[.leftShoulder]?.position.y ?? 0.0),
            leftElbowX: Double(pose.joints[.leftElbow]?.position.x ?? 0.0),
            leftElbowY: Double(pose.joints[.leftElbow]?.position.y ?? 0.0),
            leftWristX: Double(pose.joints[.leftWrist]?.position.x ?? 0.0),
            leftWristY: Double(pose.joints[.leftWrist]?.position.y ?? 0.0),
            leftHipX: Double(pose.joints[.leftHip]?.position.x ?? 0.0),
            leftHipY: Double(pose.joints[.leftHip]?.position.y ?? 0.0),
            leftKneeX: Double(pose.joints[.leftKnee]?.position.x ?? 0.0),
            leftKneeY: Double(pose.joints[.leftKnee]?.position.y ?? 0.0),
            leftAnkleX: Double(pose.joints[.leftAnkle]?.position.x ?? 0.0),
            leftAnkleY: Double(pose.joints[.leftAnkle]?.position.y ?? 0.0),
            rightEyeX: Double(pose.joints[.rightEye]?.position.x ?? 0.0),
            rightEyeY: Double(pose.joints[.rightEye]?.position.y ?? 0.0),
            rightEarX: Double(pose.joints[.rightEar]?.position.x ?? 0.0),
            rightEarY: Double(pose.joints[.rightEar]?.position.y ?? 0.0),
            rightShoulderX: Double(pose.joints[.rightShoulder]?.position.x ?? 0.0),
            rightShoulderY: Double(pose.joints[.rightShoulder]?.position.y ?? 0.0),
            rightElbowX: Double(pose.joints[.rightElbow]?.position.x ?? 0.0),
            rightElbowY: Double(pose.joints[.rightElbow]?.position.y ?? 0.0),
            rightWristX: Double(pose.joints[.rightWrist]?.position.x ?? 0.0),
            rightWristY: Double(pose.joints[.rightWrist]?.position.y ?? 0.0),
            rightHipX: Double(pose.joints[.rightHip]?.position.x ?? 0.0),
            rightHipY: Double(pose.joints[.rightHip]?.position.y ?? 0.0),
            rightKneeX: Double(pose.joints[.rightKnee]?.position.x ?? 0.0),
            rightKneeY: Double(pose.joints[.rightKnee]?.position.y ?? 0.0),
            rightAnkleX: Double(pose.joints[.rightAnkle]?.position.x ?? 0.0),
            rightAnkleY: Double(pose.joints[.rightAnkle]?.position.y ?? 0.0))

            guard let prediction = try? self.poseNetMLModel.prediction(from: input) else {
                return ""
            }

        return prediction.featureValue(for: "target")?.stringValue ?? ""
    }
}
