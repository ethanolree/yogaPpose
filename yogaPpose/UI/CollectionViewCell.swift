//
//  CollectionViewCell.swift
//  yogaPpose
//
//  Created by Ethan Olree on 12/2/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var workoutName: UILabel!
    @IBOutlet weak var workoutScore: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.cornerRadius = 10
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 5

        self.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
