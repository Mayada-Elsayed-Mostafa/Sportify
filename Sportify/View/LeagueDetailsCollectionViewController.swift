//
//  LeagueDetailsCollectionViewController.swift
//  Sportify
//
//  Created by Macos on 17/05/2025.
//

import UIKit

class LeagueDetailsCollectionViewController: UICollectionViewController {

   let sectionTitles = ["Upcoming Events", "Latest Events", "Teams"]
   var leagueType: String?
   var presenter: LeagueDetailsPresenter?

   override func viewDidLoad() {
       super.viewDidLoad()
       presenter = LeagueDetailsPresenter(vc: self)
       presenter?.getFixtures(endPoint: leagueType ?? "")
       presenter?.getTeams(endPoint: leagueType ?? "")
       setupNavigationBar()
       registerCellsAndHeaders()
       collectionView.setCollectionViewLayout(configureCompositionalLayout(), animated: true)
   }
    
   override func numberOfSections(in collectionView: UICollectionView) -> Int {
       return sectionTitles.count
   }
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       switch section {
       case 0:
           let upcomingCount = presenter?.fixtures?.filter { $0.eventStatus == "Not Started" }.count ?? 0
           return upcomingCount > 0 ? upcomingCount : 1
       case 1:
           let latestCount = presenter?.fixtures?.filter { $0.eventStatus == "Finished" }.count ?? 0
           return latestCount > 0 ? latestCount : 1
       case 2:
           let teamsCount = presenter?.teams?.count ?? 0
           return teamsCount > 0 ? teamsCount : 1
       default:
           return 0
       }
   }
    
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       switch indexPath.section {
       case 0: // Upcoming Events
           let upcomingFixtures = presenter?.fixtures?.filter { $0.eventStatus == "Not Started" } ?? []
           if indexPath.item < upcomingFixtures.count {
               let cell = dequeueCell(ofType: UpComingEvensCollectionViewCell.self, for: indexPath)
               cell.configure(with: upcomingFixtures[indexPath.item])
               return cell
           } else {
               let cell = dequeueCell(ofType: UpComingEvensCollectionViewCell.self, for: indexPath)
               cell.showPlaceholder()
               return cell
           }

       case 1: // Latest Events
           let latestFixtures = presenter?.fixtures?.filter { $0.eventStatus == "Finished" } ?? []
           if indexPath.item < latestFixtures.count {
               let cell = dequeueCell(ofType: LatestEventsCollectionViewCell.self, for: indexPath)
               cell.configure(with: latestFixtures[indexPath.item])
               return cell
           } else {
               let cell = dequeueCell(ofType: LatestEventsCollectionViewCell.self, for: indexPath)
               cell.showPlaceholder()
               return cell
           }

       case 2: // Teams
           let teams = presenter?.teams ?? []
           if indexPath.item < teams.count {
               let cell = dequeueCell(ofType: TeamCollectionViewCell.self, for: indexPath)
               cell.configure(with: teams[indexPath.item])
               return cell
           } else {
               let cell = dequeueCell(ofType: TeamCollectionViewCell.self, for: indexPath)
               cell.showPlaceholder()
               return cell
           }

       default:
           return UICollectionViewCell()
       }
   }
    
   override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       guard kind == UICollectionView.elementKindSectionHeader else { return UICollectionReusableView() }

       let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SimpleHeaderView.reuseIdentifier, for: indexPath) as! SimpleHeaderView
       header.configure(text: sectionTitles[indexPath.section])
       return header
   }
}


// MARK: - Layout Configuration

extension LeagueDetailsCollectionViewController {

   private func configureCompositionalLayout() -> UICollectionViewCompositionalLayout {
       return UICollectionViewCompositionalLayout { index, _ in
           switch index {
           case 0: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: true)
           case 1: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: false)
           case 2: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .absolute(250), isHorizontal: true)
           default: return self.drawSection(itemWidth: .fractionalWidth(1), groupHeight: 185, groupWidth: .fractionalWidth(1), isHorizontal: true)
           }
       }
   }

   private func drawSection(itemWidth: NSCollectionLayoutDimension, groupHeight: CGFloat, groupWidth: NSCollectionLayoutDimension, isHorizontal: Bool) -> NSCollectionLayoutSection {

       let itemSize = NSCollectionLayoutSize(widthDimension: itemWidth, heightDimension: .fractionalHeight(1))
       
       let item = NSCollectionLayoutItem(layoutSize: itemSize)

       let groupSize = NSCollectionLayoutSize(widthDimension: groupWidth, heightDimension: .absolute(groupHeight))
       
       let group = isHorizontal
           ? NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
           : NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

       group.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 10, bottom: 0, trailing: 10)

       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = isHorizontal ? .continuous : .none
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

       let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40))
       let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
       section.boundarySupplementaryItems = [sectionHeader]

       section.visibleItemsInvalidationHandler = { items, offset, environment in
           items.forEach { item in
               let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
               let minScale: CGFloat = 0.8
               let maxScale: CGFloat = 1.0
               let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
               item.transform = CGAffineTransform(scaleX: scale, y: scale)
           }
       }

       return section
   }
}

// MARK: - Setup & Utilities

extension LeagueDetailsCollectionViewController {

   private func setupNavigationBar() {
       let customFont = UIFont.systemFont(ofSize: 24, weight: .bold)
       let customColor = UIColor(named: "orange") ?? .orange
       navigationController?.navigationBar.titleTextAttributes = [
           .foregroundColor: customColor,
           .font: customFont
       ]
       navigationItem.title = "League"
   }

   private func registerCellsAndHeaders() {
       collectionView.register(SimpleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SimpleHeaderView.reuseIdentifier)

       collectionView.register(UINib(nibName: "UpComingEvensCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: UpComingEvensCollectionViewCell.identifier)
       collectionView.register(UINib(nibName: "LatestEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: LatestEventsCollectionViewCell.identifier)
       collectionView.register(UINib(nibName: "TeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: TeamCollectionViewCell.identifier)
   }

   private func dequeueCell<T: UICollectionViewCell>(ofType type: T.Type, for indexPath: IndexPath) -> T {
       return collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
   }
}

// MARK: - Reuse Identifiers

extension UICollectionViewCell {
   static var identifier: String {
       return String(describing: self)
   }
}

extension UICollectionReusableView {
   static var reuseIdentifier: String {
       return String(describing: self)
   }
}
