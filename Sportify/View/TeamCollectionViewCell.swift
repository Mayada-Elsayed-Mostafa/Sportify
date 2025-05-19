//
//  TeamCollectionViewCell.swift
//  Sportify
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backGround: UIImageView!
    
    @IBOutlet weak var teamImage: UIImageView!
    
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           setupBackgroundBorder()
           setupNameCorners()
       }
       
       private func setupBackgroundBorder() {
           backGround.layer.borderColor = (UIColor(named: "gray") ?? UIColor.gray).cgColor

           backGround.layer.borderWidth = 2.0
           backGround.layer.cornerRadius = 24.0
           backGround.clipsToBounds = true
       }
    
    private func setupNameCorners() {
        teamName.layer.cornerRadius = 24.0
        teamName.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        teamName.clipsToBounds = true
    }

}
