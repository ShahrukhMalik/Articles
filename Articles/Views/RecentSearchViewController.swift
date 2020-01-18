//
//  RecentSearchViewController.swift
//  Articles
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class RecentSearchViewController: UIViewController {

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    var viewModel: ArticlesListViewModel!
    
    
    // MARK: - UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchRecentSearches()
    }
    
    
    // MARK: - Private methods
    
    func configureViewModel() {        
        viewModel.reloadRecentSearchTableViewClosure =  { [weak self] (obj) in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func fetchRecentSearches() {
        viewModel.fetchRecentSearches()
    }
}

extension RecentSearchViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recentSearchViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCellIdentifier") as! RecentTableViewCell
        
        let recentViewModel : RecentSearchViewModel = viewModel.recentSearchViewModels[indexPath.row]
        
        cell.mainLabel.text = recentViewModel.term
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.recentTitle
    }
}

extension RecentSearchViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let recentViewModel : RecentSearchViewModel = viewModel.recentSearchViewModels[indexPath.row]
        viewModel.searchTermClicked(searchTerm: recentViewModel.term)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}
