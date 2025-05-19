//
//  UpComingEvensCollectionViewCell.swift
//  Sportify
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class UpComingEvensCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backGround: UIImageView!
    
    @IBOutlet weak var logoTeam1: UIImageView!
    
    @IBOutlet weak var nameTeam1: UILabel!
    
    @IBOutlet weak var nameTeam2: UILabel!
    
    @IBOutlet weak var logoTeam2: UIImageView!
    
    @IBOutlet weak var matchDate: UILabel!
    
    @IBOutlet weak var matchTime: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           setupBackgroundCorners()
           
       }
       
       private func setupBackgroundCorners() {
           backGround.layer.cornerRadius = 12.0
           backGround.clipsToBounds = true
       }

}
