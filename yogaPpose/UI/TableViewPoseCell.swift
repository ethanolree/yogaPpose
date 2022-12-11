//
//  TableViewPoseCell.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/10/22.
//

import UIKit

class TableViewPoseCell: UITableViewCell, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var posePicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    
    lazy private var workoutsModel:WorkoutsModel = {
        return WorkoutsModel.sharedInstance
    }()
    
    var workoutBuilder: WorkoutBuilder!
    var poseIndex: Int!
    var initPose: (String, Double)? {
        didSet {
            self.posePicker.selectRow(workoutsModel.posesArray.firstIndex(of: initPose!.0) ?? 0, inComponent: 0, animated: false)
            self.timePicker.selectRow(Int(initPose!.1/5 - 1), inComponent: 0, animated: false)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.posePicker.delegate = self
        self.posePicker.dataSource = self
        
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == posePicker) {
            return workoutsModel.posesArray.count
        } else {
            return 12
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == posePicker) {
            let poseId: String = workoutsModel.posesArray[row]
            return workoutsModel.poseNames[poseId]
        } else {
            return String((row + 1) * 5)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == posePicker) {
            let poseId: String = workoutsModel.posesArray[row]
            workoutBuilder.setPoseForIndex(index: poseIndex, pose: poseId)
        } else {
            workoutBuilder.setTimeForIndex(index: poseIndex, time: (row + 1) * 5)
        }
    }

}
