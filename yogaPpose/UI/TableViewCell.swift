//
//  TableViewCell.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    
    var workout: Workout? {
        didSet {
            title.text = workout?.name
            setPoseImages(imageView: image1, index: 0)
            setPoseImages(imageView: image2, index: 1)
            setPoseImages(imageView: image3, index: 2)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setPoseImages(imageView: UIImageView, index: Int) {
        if (workout?.workoutPoses.count ?? 0 > index) {
            imageView.image = WorkoutPose.getPoseImage(name: workout?.workoutPoses[index].poseImageName ?? "")
        } else {
            imageView.backgroundColor = UIColor(white: 1, alpha: 0.0)
        }
    }

}
