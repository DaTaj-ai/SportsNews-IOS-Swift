//
//  FavoritesViewController.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 30/05/2025.
//

import UIKit

protocol FavoritesViewControllerProtocal {
    func renderData()
    // navigation
}

class FavoritesViewController: UITableViewController, FavoritesViewControllerProtocal {
    
    var presenter: FavoritePresenter?
    
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        tableView.contentInsetAdjustmentBehavior = .automatic
        setupTableView()
        presenter = FavoritePresenter(vc: self)
        presenter?.getFavoritesLeague()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        presenter?.getFavoritesLeague()
    }
    
    // MARK: - Table View Setup
    private func setupTableView() {
        let nib = UINib(nibName: "LeagueTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "favoritecell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.contentInset.top = 0
    }


    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HomeHeaderView()
        headerView.titleLabel.text = "Favorite Leagues"
        headerView.backgroundColor = .systemBackground
        return headerView
    }

    private func performDelete(at indexPath: IndexPath) {
        guard let leagueName = presenter?.favoritesLeagueList[indexPath.row].leagueName else { return }
        
        // 1. Perform the deletion in data source first
        presenter?.deleteFavoritesLeague(leagueName: leagueName)
        
        // 2. Immediately update the table view
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }, completion: { [weak self] _ in
            self?.checkEmptyState()
        })
    }

    private func showDeleteConfirmation(for indexPath: IndexPath) {
        guard let leagueName = presenter?.favoritesLeagueList[indexPath.row].leagueName else { return }
        
        let alert = UIAlertController(
            title: "Delete Favorite",
            message: "Are you sure you want to remove \(leagueName) from favorites?",
            preferredStyle: .alert
        )
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            self?.performDelete(at: indexPath)
            // Remove the redundant reloadData() call here
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    // MARK: - Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.favoritesLeagueList.count ?? 0
    }
    
    // MARK: - Protocol Implementation
    func renderData() {
        // Always perform UI updates on main thread
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.checkEmptyState()
        }
    }
    
    private func checkEmptyState() {
        let isEmpty = presenter?.favoritesLeagueList.isEmpty ?? true
        tableView.backgroundView = isEmpty ? createEmptyStateView() : nil
        tableView.separatorStyle = isEmpty ? .none : .singleLine
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    // MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath) as! LeagueTableCell
        guard let league = presenter?.favoritesLeagueList[indexPath.row] else {
            print("No league data at index \(indexPath.row)")
            return cell
        }
        
        print("League at row \(indexPath.row): \(league)")
        
        print("Image URL: \(league.leagueImageUrl )")
        print("Image URL is empty: \(league.leagueImageUrl.isEmpty )")
        
        cell.configure(
            with: league.leagueName ,
            image: league.leagueImageUrl 
        )
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] (_, _, completion) in
            self?.showDeleteConfirmation(for: indexPath)
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        deleteAction.image = UIImage(systemName: "trash.fill")
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            showDeleteConfirmation(for: indexPath)
        }
    }
    
    
    // MARK: - Empty State Handling
    
    private func checkEmptyState(isEmpty: Bool) {
        tableView.backgroundView = isEmpty ? createEmptyStateView() : nil
        tableView.separatorStyle = isEmpty ? .none : .singleLine
    }
    
    private func createEmptyStateView() -> UIView {
        let emptyView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: tableView.bounds.height))
        
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.text = "No Favorites Yet"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        emptyView.addSubview(imageView)
        emptyView.addSubview(label)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: -50),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            label.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            label.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 32),
            label.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -32)
        ])
        
        return emptyView
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tabed")
        NetworkManager.isInternetAvailable { isConnected in
            if isConnected {
                print("Internet connection is available")
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "LeagueEventsView", bundle: nil)
                    
                    guard let leagueVC = storyboard.instantiateViewController(withIdentifier: "LeagueEventsCollectionViewController") as? LeagueEventsCollectionViewController else {
                        fatalError("LeagueEventsCollectionViewController not found in storyboard.")
                    }
                    if let leagueKey = self.presenter?.favoritesLeagueList[indexPath.row].leagueKey{
                        leagueVC.leagueKey = leagueKey
                        print("yes")
                    }
                    else{
                        leagueVC.leagueKey = "210"
                        print("nooooooooooo")

                    }
                    leagueVC.sportType = self.presenter?.favoritesLeagueList[indexPath.row].endPoint
                    leagueVC.favoriteLeague = self.presenter?.favoritesLeagueList[indexPath.row]
                    self.navigationController?.pushViewController(leagueVC, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    print("No internet connection")
                    NetworkManager.showNoInternetAlert(on: self)
                }
            }
        }
                
    }
    
    
}
