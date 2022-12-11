/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The implementation of the application's view controller, responsible for coordinating
 the user interface, video feed, and PoseNet model.
*/

import AVFoundation
import UIKit
import VideoToolbox

class PoseViewController: UIViewController {
    /// The view the controller uses to visualize the detected poses.
    @IBOutlet weak var previewImageView: PoseImageView!
    @IBOutlet weak var currentPoseImage: UIImageView!
    @IBOutlet weak var poseGradient: GradientOverlayView!
    
    /// The workout as currently selected by the user
    var workout: Workout!
    
    /// The current pose of the workout
    var currentPose: WorkoutPose!
    
    private let videoCapture = VideoCapture()

    private var poseNet: PoseNet!
    
    private var yogaPose = YogaPose()

    /// The frame the PoseNet model is currently making pose predictions from.
    private var currentFrame: CGImage?

    /// The algorithm the controller uses to extract poses from the current frame.
    private var algorithm: Algorithm = .single
    
    private var poses: [Pose]!

    /// The set of parameters passed to the pose builder when detecting poses.
    private var poseBuilderConfiguration = PoseBuilderConfiguration()

    private var popOverPresentationManager: PopOverPresentationManager?

    // For scoring the workout
    let defaults = UserDefaults.standard
    private var score: [String: Double] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.beginAppearanceTransition(true, animated: false)
        self.tabBarController?.tabBar.isHidden = true
        self.poseGradient.isHidden = true
        self.currentPoseImage.isHidden = true
        
        performSegue(withIdentifier: "initialPoseModalSegue", sender: self)

        // For convenience, the idle timer is disabled to prevent the screen from locking.
        UIApplication.shared.isIdleTimerDisabled = true

        do {
            poseNet = try PoseNet()
        } catch {
            fatalError("Failed to load model. \(error.localizedDescription)")
        }

        poseNet.delegate = self
        setupAndBeginCapturingVideoFrames()
    }

    private func setupAndBeginCapturingVideoFrames() {
        videoCapture.setUpAVCapture { error in
            if let error = error {
                print("Failed to setup camera with error \(error)")
                return
            }

            self.videoCapture.delegate = self
            
            self.videoCapture.flipCamera { error in
                if let error = error {
                    print("Failed to flip camera with error \(error)")
                }
            }

            self.videoCapture.startCapturing()
        }
    }
    
    private func setupPoseTimer() {
        initiateNextPose(poseIndex: 0)
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            let prediction = self.yogaPose.predict(self.poses[0])
            
            if (prediction == self.currentPose.id) {
                self.currentPoseImage.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                self.poseGradient.endColor = UIColor.green
                self.score[self.currentPose.name] = self.score[self.currentPose.name]! + 1
            } else {
                self.currentPoseImage.backgroundColor = UIColor.red.withAlphaComponent(0.5)
                self.poseGradient.endColor = UIColor.red
                
            }
        }
    }
    
    private func initiateNextPose(poseIndex: Int) {
        if (poseIndex >= self.workout.workoutPoses.count) {
            return
        } else {
            self.currentPose = self.workout.workoutPoses[poseIndex]
            self.currentPoseImage.image = WorkoutPose.getPoseImage(name: self.currentPose.poseImageName) 
            self.score[self.currentPose.name] = 0
            
            /// Set a timer to change to the next pose once the current one is finished
            _ = Timer.scheduledTimer(withTimeInterval: self.currentPose.length, repeats: false) { timer in
                self.initiateNextPose(poseIndex: poseIndex + 1)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        var success = 0.0
        var outOf = 0.0
        for (index, keyValue) in self.score.enumerated() {
            success += keyValue.value
            outOf += self.workout.workoutPoses[index].length
        }
        defaults.set(success/outOf, forKey: self.workout.name)
        self.tabBarController?.tabBar.isHidden = false
        videoCapture.stopCapturing {
            super.endAppearanceTransition()
        }
    }

    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        // Reinitilize the camera to update its output stream with the new orientation.
        setupAndBeginCapturingVideoFrames()
    }

    @IBAction func onCameraButtonTapped(_ sender: Any) {
        videoCapture.flipCamera { error in
            if let error = error {
                print("Failed to flip camera with error \(error)")
            }
        }
    }
    
    @IBAction func startWorkout(segue: UIStoryboardSegue) {
        self.poseGradient.isHidden = false
        self.currentPoseImage.isHidden = false
        setupPoseTimer()
    }
}

// MARK: - Navigation

extension PoseViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let startViewController = segue.destination as? StartViewController {
            startViewController.workout = self.workout
        }
        
        /*guard let uiNavigationController = segue.destination as? UINavigationController else {
            return
        }
        guard let configurationViewController = uiNavigationController.viewControllers.first
            as? ConfigurationViewController else {
                    return
        }

        configurationViewController.configuration = poseBuilderConfiguration
        configurationViewController.algorithm = algorithm
        configurationViewController.delegate = self

        popOverPresentationManager = PopOverPresentationManager(presenting: self,
                                                                presented: uiNavigationController)
        segue.destination.modalPresentationStyle = .custom
        segue.destination.transitioningDelegate = popOverPresentationManager*/
    }
}

// MARK: - ConfigurationViewControllerDelegate

extension PoseViewController: ConfigurationViewControllerDelegate {
    func configurationViewController(_ viewController: ConfigurationViewController,
                                     didUpdateConfiguration configuration: PoseBuilderConfiguration) {
        poseBuilderConfiguration = configuration
    }

    func configurationViewController(_ viewController: ConfigurationViewController,
                                     didUpdateAlgorithm algorithm: Algorithm) {
        self.algorithm = algorithm
    }
}

// MARK: - VideoCaptureDelegate

extension PoseViewController: VideoCaptureDelegate {
    func videoCapture(_ videoCapture: VideoCapture, didCaptureFrame capturedImage: CGImage?) {
        guard currentFrame == nil else {
            return
        }
        guard let image = capturedImage else {
            fatalError("Captured image is null")
        }

        currentFrame = image
        poseNet.predict(image)
    }
}

// MARK: - PoseNetDelegate

extension PoseViewController: PoseNetDelegate {
    func poseNet(_ poseNet: PoseNet, didPredict predictions: PoseNetOutput) {
        defer {
            // Release `currentFrame` when exiting this method.
            self.currentFrame = nil
        }

        guard let currentFrame = currentFrame else {
            return
        }

        let poseBuilder = PoseBuilder(output: predictions,
                                      configuration: poseBuilderConfiguration,
                                      inputImage: currentFrame)

        let poses = algorithm == .single
            ? [poseBuilder.pose]
            : poseBuilder.poses
        
        self.poses = poses

        previewImageView.show(poses: poses, on: currentFrame)
    }
}
