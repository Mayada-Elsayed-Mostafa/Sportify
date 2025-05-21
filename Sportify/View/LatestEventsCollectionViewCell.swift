import UIKit
import SDWebImage

class LatestEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoTeam1: UIImageView!
    @IBOutlet weak var nameTeam1: UILabel!
    @IBOutlet weak var logoTeam2: UIImageView!
    @IBOutlet weak var nameTeam2: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    func configure(with fixture: Fixture) {
        nameTeam1.text = fixture.eventHomeTeam
        nameTeam2.text = fixture.eventAwayTeam
        matchDate.text = fixture.eventDate
        matchTime.text = fixture.eventTime
        score.text = fixture.eventFinalResult
        
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
        nameTeam2.text = ""
        matchDate.text = ""
        matchTime.text = ""
        score.text = ""
        logoTeam1.image = UIImage(named: "placeholder")
        logoTeam2.image = UIImage(named: "placeholder")
    }
}
