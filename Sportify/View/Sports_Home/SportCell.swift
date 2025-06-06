import UIKit

class SportCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        
        sportImageView.layer.cornerRadius = 16
        sportImageView.layer.masksToBounds = true
    }
}
