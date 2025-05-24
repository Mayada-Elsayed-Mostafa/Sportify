import UIKit

class LeagueDetailsCollectionViewController: UICollectionViewController {
    
    let sectionTitles = ["Upcoming Events", "Latest Events", "Teams"]
    var leagueType: String?
    var leagueId: Int?
    
    var presenter: LeagueDetailsPresenter?
    
    var league: League?
    
    private var heartButton: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LeagueDetailsPresenter(vc: self, localSource: LeagueLocalSource())
        presenter?.getFixtures(endPoint: leagueType ?? "", leagueId: leagueId!)
        presenter?.getTeams(endPoint: leagueType ?? "", leagueId: leagueId!)
        
        collectionView.register(NoDataCollectionViewCell.self, forCellWithReuseIdentifier: NoDataCollectionViewCell.identifier)
        
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
            return max(presenter?.upcomingFixtures?.count ?? 0, 1)
        case 1:
            return max(presenter?.latestFixtures?.count ?? 0, 1)
        case 2:
            return max(presenter?.teams?.count ?? 0, 1)
        default:
            return 0
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0: // Upcoming
            let count = presenter?.upcomingFixtures?.count ?? 0
            if count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.identifier, for: indexPath) as! NoDataCollectionViewCell
                return cell
            } else {
                let cell = dequeueCell(ofType: UpComingEvensCollectionViewCell.self, for: indexPath)
                if let fixture = presenter?.upcomingFixtures?[indexPath.item] {
                    cell.configure(with: fixture)
                }
                return cell
            }
            
        case 1: // Latest
            let count = presenter?.latestFixtures?.count ?? 0
            if count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.identifier, for: indexPath) as! NoDataCollectionViewCell
                return cell
            } else {
                let cell = dequeueCell(ofType: LatestEventsCollectionViewCell.self, for: indexPath)
                if let fixture = presenter?.latestFixtures?[indexPath.item] {
                    cell.configure(with: fixture)
                }
                return cell
            }
            
        case 2: // Teams
            let count = presenter?.teams?.count ?? 0
            if count == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoDataCollectionViewCell.identifier, for: indexPath) as! NoDataCollectionViewCell
                return cell
            } else {
                let cell = dequeueCell(ofType: TeamCollectionViewCell.self, for: indexPath)
                if let team = presenter?.teams?[indexPath.item] {
                    cell.configure(with: team)
                }
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        switch indexPath.section {
            case 2:
            if leagueType == Constants.FOOTBALL{
                let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
                navigationController?.pushViewController(teamDetailsVC, animated: true)
                
                teamDetailsVC.team = presenter?.teams?[indexPath.row]
                teamDetailsVC.leagueType = self.leagueType
            }
            default:
                    print("none")
        }
    }
}

// MARK: - Setup & Utilities

extension LeagueDetailsCollectionViewController {
    


    private func setupNavigationBar() {
        let customFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let customColor = UIColor(named: "orange") ?? .orange

        // Set title style
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: customColor,
            .font: customFont
        ]
        navigationItem.title = "League"

        // Create the heart icon (start with empty)
        let heartImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        heartButton = UIBarButtonItem(image: heartImage,
                                       style: .plain,
                                       target: self,
                                       action: #selector(toggleHeart))
        heartButton?.tintColor = customColor
        navigationItem.rightBarButtonItem = heartButton
    }
    
    @objc private func toggleHeart() {
        
        let imageName = presenter?.toggleHeart() ?? false ? "heart.fill" : "heart"
        heartButton?.image = UIImage(systemName: imageName)
        
    
        let res = presenter?.saveLeagueToCoreData(league: (self.league)!)
        switch res {
        case .success:
            print("League saved successfully")
        case .failure(let error):
            print("Failed to save league: \(error.localizedDescription)")
        case .none:
            print(self.league?.leagueName)
        }
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
