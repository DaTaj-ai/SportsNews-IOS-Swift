import UIKit

class LeagueEventsCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    private let sectionTitles = ["Upcoming Events", "Latest Events", "Teams"]
    var sportType: String?
    var leagueKey: String?
    
    var presenter = LeagueDetailsPresenter()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPresenter()
        setupCollectionView()
        loadData()
        
    }
    
    private func setupPresenter() {
        presenter.view = self
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = createCompositionalLayout()
        collectionView.backgroundColor = .systemBackground
        registerCells()
    }
    
    private func loadData() {
        guard let sportType = sportType, let leagueKey = leagueKey else { return }
        presenter.loadFixtures(sportType: sportType, leagueId: leagueKey)
        presenter.loadTeams(sportType: sportType, leagueId: leagueKey)
    }
    
    // MARK: - Compositional Layout
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            switch sectionIndex {
            case 0: return self.createHorizontalSection(height: 180)
            case 1: return self.createVerticalSection(height: 120)
            case 2: return self.createHorizontalSection(height: 150)
            default: return self.createHorizontalSection(height: 180)
            }
        }
    }
    
    private func createHorizontalSection(height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))

        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(180),
            heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 15, bottom: 20, trailing: 15)
        
        // Section header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    private func createVerticalSection(height: CGFloat) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 10, leading: 15, bottom: 20, trailing: 15)
        
        // Section header
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    // MARK: - Data Source
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionTitles.count
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return presenter.upcomingEvents.isEmpty ? 1 : presenter.upcomingEvents.count
        case 1: return presenter.latestEvents.isEmpty ? 1 : presenter.latestEvents.count
        case 2: return presenter.teams.isEmpty ? 1 : presenter.teams.count
        default: return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0: return upcomingEventsCell(for: indexPath)
        case 1: return latestEventsCell(for: indexPath)
        case 2: return teamsCell(for: indexPath)
        default: return UICollectionViewCell()
        }
    }
    
    private func upcomingEventsCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard !presenter.upcomingEvents.isEmpty else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "NoDataCell",
                for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "UpcomingEventCell",
            for: indexPath) as! UpComingEvensCollectionViewCell
        cell.configure(with: presenter.upcomingEvents[indexPath.item])
        return cell
    }
    
    private func latestEventsCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard !presenter.latestEvents.isEmpty else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "NoDataCell",
                for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "LatestEventCell",
            for: indexPath) as! LatestEventsCollectionViewCell
        cell.configure(with: presenter.latestEvents[indexPath.item])
        return cell
    }
    
    private func teamsCell(for indexPath: IndexPath) -> UICollectionViewCell {
        guard !presenter.teams.isEmpty else {
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: "NoDataCell",
                for: indexPath)
        }
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "TeamCell",
            for: indexPath) as! TeamCollectionViewCell
        cell.configure(with: presenter.teams[indexPath.item])
        return cell
    }
    
    // MARK: - Section Headers
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: "SectionHeader",
            for: indexPath) as! SimpleHeaderView
        header.titleLabel.text = sectionTitles[indexPath.section]
        return header
    }
    
    // MARK: - Cell Registration
    private func registerCells() {
        // Register cells
        collectionView.register(
            UINib(nibName: "UpComingEvensCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "UpcomingEventCell"
        )
        collectionView.register(
            UINib(nibName: "LatestEventsCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "LatestEventCell"
        )
        collectionView.register(
            UINib(nibName: "TeamCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "TeamCell"
        )
        collectionView.register(
            NoDataCollectionViewCell.self,
            forCellWithReuseIdentifier: "NoDataCell"
        )
        
        // Register header
        collectionView.register(
            SimpleHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "SectionHeader"
        )
    }
}

// MARK: - Presenter Interface Implementation
extension LeagueEventsCollectionViewController: LeagueDetailsView {
    func reloadUpcomingEvents() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func reloadLatestEvents() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func reloadTeams() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func showError(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
