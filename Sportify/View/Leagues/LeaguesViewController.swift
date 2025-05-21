import UIKit
import SDWebImage

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var leaguesTableView: UITableView!
    var leagues: [League] = []
    var presenter: LeaguesPresenter?
    var leagueType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = LeaguesPresenter(vc: self, localSource: LeagueLocalSource())
       
        presenter?.getLeagues(endPoint: leagueType ?? "football")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)
        (cell.viewWithTag(2) as! UILabel).text = leagues[indexPath.row].leagueName
        
        let imageView = (cell.viewWithTag(1) as! UIImageView)
        
        switch leagueType{
            case Constants.FOOTBALL:
                imageView.sd_setImage(with:URL(string: leagues[indexPath.row].leagueLogo ?? ""))
            case Constants.BASKETBALL:
                imageView.image = UIImage(named: "basketball")
            case Constants.TENNIS:
                imageView.image = UIImage(named: "tennis")
            case Constants.CRICKET:
                imageView.image = UIImage(named: "cricket")
            default:
                imageView.sd_setImage(with:URL(string: leagues[indexPath.row].leagueLogo ?? ""))
        }

        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        leagues[indexPath.row].sportType = leagueType

        
        if let leaguesDetailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsCollectionViewController") as? LeagueDetailsCollectionViewController {
            
            leaguesDetailsVC.leagueType = leagueType
            leaguesDetailsVC.leagueId = leagues[indexPath.row].leagueKey
            leaguesDetailsVC.league = leagues[indexPath.row]
  
            navigationController?.pushViewController(leaguesDetailsVC, animated: true)
        }
    }
    
}
