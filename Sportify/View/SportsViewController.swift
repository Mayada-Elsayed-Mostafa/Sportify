//
//  SportsViewController.swift
//  Sportify
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: SportsPresenter!
    var sports: [Sport] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = SportsPresenter(view: self)

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: "SportCell", bundle: nil), forCellWithReuseIdentifier: "SportCell")

        presenter.fetchSports()
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
