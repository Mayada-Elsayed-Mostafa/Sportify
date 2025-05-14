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
    var presenter: LeaguesPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("didLoad")
        presenter = LeaguesPresenter(vc: self)
        presenter?.getLeagues()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(leagues.count)
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)
        (cell.viewWithTag(2) as! UILabel).text = leagues[indexPath.row].leagueName
        
        let imageView = (cell.viewWithTag(1) as! UIImageView)
        imageView.sd_setImage(with:URL(string: leagues[indexPath.row].leagueLogo ?? ""))
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
