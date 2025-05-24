import UIKit
import SDWebImage

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupNameCorners()
        styleImageView(teamImage) 
    }
    
    private func styleImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor(named: "SecondaryColor")?.cgColor ?? UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill
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
        teamImage.image = UIImage(named: "placeholder")
    }
}
