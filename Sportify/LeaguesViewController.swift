//
//  LeaguesViewController.swift
//  Sportify
//
//  Created by Macos on 13/05/2025.
//

import UIKit
import SDWebImage

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var leaguesTableView: UITableView!
    var leagues: [League] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("didLoad")
        SportsApiService.shared.getLeagues{
            [weak self] leagues in
                    guard let self = self else { return }
                    if let leagues = leagues {
                        self.leagues = leagues
                        DispatchQueue.main.async {
                            self.leaguesTableView.reloadData()
                        }
                    } else {
                        print("❌ Failed to load leagues")
                    }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(leagues.count)
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)
        (cell.viewWithTag(2) as! UILabel).text = "Uefa Champions league"
        let imageView = (cell.viewWithTag(1) as! UIImageView)
        imageView.sd_setImage(with:URL(string: "https://m.media-amazon.com/images/M/MV5BNWE5MGI3MDctMmU5Ni00YzI2LWEzMTQtZGIyZDA5MzQzNDBhXkEyXkFqcGc@._V1_SX300.jpg"))
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
}
