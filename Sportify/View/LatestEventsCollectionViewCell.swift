//
//  LatestEventsCollectionViewCell.swift
//  Sportify
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class LatestEventsCollectionViewCell: UICollectionViewCell {

    
     @IBOutlet weak var backGround: UIImageView!
     
     @IBOutlet weak var logoTeam1: UIImageView!
     
     @IBOutlet weak var nameTeam1: UILabel!
     
     @IBOutlet weak var logoTeam2: UIImageView!
     
     @IBOutlet weak var nameTeam2: UILabel!
     
     @IBOutlet weak var score: UILabel!
     
     @IBOutlet weak var matchDate: UILabel!
     
     @IBOutlet weak var matchTime: UILabel!
     
     
     override func awakeFromNib() {
            super.awakeFromNib()
         setupBackgourndBorder()
         /*
         someView.backgroundColor = UIColor(named: "mainBackground")
         label.textColor = UIColor(named: "primaryText")
         scoreLabel.textColor = UIColor(named: "scoreColor")
          */
        }
        
        private func setupBackgourndBorder() {
            backGround.layer.borderColor = (UIColor(named: "SecondaryColor") ?? UIColor.gray).cgColor

            backGround.layer.borderWidth = 2.0
            backGround.layer.cornerRadius = 24.0
            backGround.clipsToBounds = true
        }

 }
