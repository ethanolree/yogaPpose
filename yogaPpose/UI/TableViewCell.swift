//
//  TableViewCell.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import UIKit

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var imageCollection: UICollectionView!
    
    var workout: Workout? {
        didSet {
            title.text = workout?.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        imageCollection.delegate = self
        imageCollection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.workout?.workoutPoses.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dynamicCellId = "imageCell"
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dynamicCellId, for: indexPath) as? ImageCollectionViewCell {
            cell.imageView.image = WorkoutPose.getPoseImage(name: workout?.workoutPoses[indexPath.row].poseImageName ?? "")
            return cell
        } else {
            fatalError("Could not dequeue cell")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
