import UIKit

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: SportsPresenter!
    var sports: [Sport] = []
    var currentAlert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        presenter = SportsPresenter(view: self)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SportCell", bundle: nil), forCellWithReuseIdentifier: "SportCell")
        
        presenter.fetchSports()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let leaguesVC = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController") as? LeaguesViewController {
            
            switch indexPath.row{
            case 0:
                leaguesVC.leagueType = Constants.FOOTBALL
            case 1:
                leaguesVC.leagueType = Constants.BASKETBALL
            case 2:
                leaguesVC.leagueType = Constants.TENNIS
            case 3:
                leaguesVC.leagueType = Constants.CRICKET
            default:
                leaguesVC.leagueType = Constants.FOOTBALL
            }
            leaguesVC.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }
    
    
    @objc func networkStatusChanged(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let isConnected = userInfo["isConnected"] as? Bool else { return }
        
        let title = isConnected ? "Internet Restored" : "No Internet Connection"
        let message = isConnected
            ? "Your internet connection is back online."
            : "Please check your internet settings and try again."
        print("networkStatusChanged")
        DispatchQueue.main.async {
            // Dismiss existing alert if any
            if let alert = self.currentAlert {
                alert.dismiss(animated: false)
                self.currentAlert = nil
            }
            
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
                self.currentAlert = nil
            })
            self.currentAlert = alert
            self.present(alert, animated: true)
        }
    }
    
}

extension SportsViewController: SportsViewProtocol {
    func showSports(_ sports: [Sport]) {
        self.sports = sports
        collectionView.reloadData()
    }
}

extension SportsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportCell", for: indexPath) as? SportCell else {
            return UICollectionViewCell()
        }
        
        let sport = sports[indexPath.item]
        cell.sportNameLabel.text = sport.name
        cell.sportImageView.image = UIImage(named: sport.imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 170
        let height: CGFloat = 210
        
        return CGSize(width: width, height: height)
    }
    

    

}
