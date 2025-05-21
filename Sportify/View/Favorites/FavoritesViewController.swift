//
//  FavoritesViewController.swift
//  Sportify
//
//  Created by Macos on 19/05/2025.
//

import UIKit

class FavoritesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    

    @IBOutlet weak var tableView: UITableView!
    var leagues: [League] = []
    var presenter: FavoritePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritePresenter(vc: self, localSource: LeagueLocalSource())

    }
    

    override func viewWillAppear(_ animated: Bool) {
        let result = presenter?.getAllLeagues()
        
        switch result {
        case .success(let leagues):
            print("Successfully fetched \(leagues.count) leagues")
            // Use `leagues` here
            self.leagues = leagues
            tableView.reloadData()
        case .failure(let error):
            print("Failed to fetch leagues: \(error.localizedDescription)")
        case .none:
            print("Error")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        (cell.viewWithTag(2) as! UILabel).text = leagues[indexPath.row].leagueName
        print("sportType \(leagues[indexPath.row].sportType)")
        
        let imageView = (cell.viewWithTag(1) as! UIImageView)
        
        switch leagues[indexPath.row].sportType{
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
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 1. Remove item from the data source
            presenter?.deleteLeague(league: leagues[indexPath.row])
            leagues.remove(at: indexPath.row)
            // 2. Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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
