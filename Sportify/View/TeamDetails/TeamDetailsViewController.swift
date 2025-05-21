//
//  TeamDetailsViewController.swift
//  Sportify
//
//  Created by Macos on 21/05/2025.
//

import UIKit

class TeamDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var tabelView: UITableView!
    var team: Team?
    var leagueType: String?
    var presenter: TeamDetailsPresenter?
  
    var sectionedPlayers: [(title: String, players: [Player])] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TeamDetailsPresenter(vc: self)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.getTeamMembers(endPoint: leagueType!, teamId: (team?.teamKey)!)
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionedPlayers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionedPlayers[section].players.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionedPlayers[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        let player = sectionedPlayers[indexPath.section].players[indexPath.row]
        (cell.viewWithTag(2) as! UILabel).text = player.playerName
        
        let imageView = (cell.viewWithTag(1) as! UIImageView)
        
        imageView.sd_setImage(with:URL(string: player.playerImage ?? ""), placeholderImage: UIImage(named: "unkown"))
        
        
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
