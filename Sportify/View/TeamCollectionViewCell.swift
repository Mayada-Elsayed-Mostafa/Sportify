//
//  TeamCollectionViewCell.swift
//  Sportify
//
//  Created by Macos on 18/05/2025.
//

import UIKit
import SDWebImage

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

    func configure(with team: Team) {
        teamName.text = team.strTeam
        
        if let logo = team.strTeamBadge, let url = URL(string: logo) {
            teamImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        } else {
            teamImage.image = UIImage(named: "placeholder")
        }
    }
    
    func showPlaceholder() {
        teamName.text = "No Data"
        teamImage.image = UIImage(named: "placeholder")
        backGround.alpha = 0.5
    }
}
