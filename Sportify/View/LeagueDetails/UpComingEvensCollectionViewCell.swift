import UIKit
import SDWebImage

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
        styleImageView(logoTeam1)
        styleImageView(logoTeam2)
    }
    
    private func styleImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor(named: "SecondaryColor")?.cgColor ?? UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill
    }
    
    
    private func setupBackgroundCorners() {
        backGround.layer.cornerRadius = 16.0
        backGround.clipsToBounds = true
    }
    
    func configure(with fixture: Fixture) {
        nameTeam1.text = fixture.eventHomeTeam
        nameTeam2.text = fixture.eventAwayTeam
        matchDate.text = fixture.eventDate
        matchTime.text = fixture.eventTime
        
        if let logo1 = fixture.homeTeamLogo, let url1 = URL(string: logo1) {
            logoTeam1.sd_setImage(with: url1, placeholderImage: UIImage(named: "placeholder"))
        } else {
            logoTeam1.image = UIImage(named: "placeholder")
        }
        
        if let logo2 = fixture.awayTeamLogo, let url2 = URL(string: logo2) {
            logoTeam2.sd_setImage(with: url2, placeholderImage: UIImage(named: "placeholder"))
        } else {
            logoTeam2.image = UIImage(named: "placeholder")
        }
    }
    
    func showPlaceholder() {
        nameTeam1.text = "No Data"
        nameTeam2.text = "No Data"
        matchDate.text = "No Data"
        matchTime.text = "No Data"
        logoTeam1.image = UIImage(named: "placeholder")
        logoTeam2.image = UIImage(named: "placeholder")
        backGround.alpha = 0.5
    }
    
}
