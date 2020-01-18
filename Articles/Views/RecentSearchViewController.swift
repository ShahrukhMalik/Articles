//
//  RecentSearchViewController.swift
//  Articles
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class RecentSearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    private var recentSearchListViewModel: RecentSearchListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchRecentSearches()
    }
    
    func configureViewModel() {
        let core = CoreDataManager()
        let repo = RecentSearchRepository(aCoreDataManager: core)
        recentSearchListViewModel = RecentSearchListViewModel(rep: repo)
        
        recentSearchListViewModel.reloadTableViewClosure =  { [weak self] (obj) in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func fetchRecentSearches() {
        recentSearchListViewModel.fetchRecentSearches()
    }
}

extension RecentSearchViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearchListViewModel.recentSearchViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCellIdentifier") as! RecentTableViewCell
        
        let recentViewModel : RecentSearchViewModel = recentSearchListViewModel.recentSearchViewModels[indexPath.row]
        
        cell.mainLabel.text = recentViewModel.term
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return recentSearchListViewModel.title
    }
}

extension RecentSearchViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recentViewModel : RecentSearchViewModel = recentSearchListViewModel.recentSearchViewModels[indexPath.row]
        recentSearchListViewModel.sendSelectedTerm(term: recentViewModel.term)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}
