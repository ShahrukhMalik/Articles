//
//  ArticlesListViewController.swift
//  Articles
//
//  Created by Shahrukh Malik on 1/15/20.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class ArticlesListViewController: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var containerView: UIView!
    
    var recentViewController : RecentSearchViewController?
    
    
    // MARK: - Properties
    private var articlesListViewModel: ArticlesListViewModel!
    
    let searchBar: UISearchBar = UISearchBar()
    
    var currentPageNumber: Int = 0
    
    
    // MARK:- UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configureViewModel()
        self.configureNavBar()
        self.configureSearchView()
    }
    
    
    // MARK:- Private methods
    
    private func configureSearchView() {
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.tintColor = UIColor.colorRGB(red: 255, green: 47, blue: 62, alpha: 1.0)
    }
    
    private func configureNavBar() {
        
        // Right Bar Item
        let searchButton = UIButton(type: .custom)
        searchButton.addTarget(self, action:#selector(handleSearch), for: .touchUpInside)
        searchButton.tintColor = .white
        let searchIcon = articlesListViewModel.searchImage
        searchButton.setImage(searchIcon , for: .normal)
        let searchBarButtonItem = UIBarButtonItem(customView: searchButton)
        
        self.navigationItem.rightBarButtonItem = searchBarButtonItem
    }
    
    @objc private func handleSearch() {
        articlesListViewModel.isSearchVisible = !articlesListViewModel.isSearchVisible
    }
    
    private func configureViewModel() {
        self.articlesListViewModel = ArticlesListViewModel()
        self.articlesListViewModel.delegate = self
        self.fetchArticles()
        
        self.title = self.articlesListViewModel.screenTitle
        
        self.articlesListViewModel.reloadTableViewClosure =  { [weak self] (obj) in
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        self.articlesListViewModel.reloadTableViewWithSearchTextClosure = { [weak self] (searchText) in
            self?.articlesListViewModel.filterArticleViewModelWithText(searchText: searchText!)
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func fetchArticles() {
        self.articlesListViewModel.fetchArticles(request: Request.Fetch.ArticleRequest(pageNumber: currentPageNumber))
    }
    
    private func getArticleViewModel( at indexPath: IndexPath ) -> ArticleViewModel {
        return articlesListViewModel.filteredArticleViewModels[indexPath.row]
    }
    
    func closeSearch() {
        searchBar.resignFirstResponder()
        searchBar.endEditing(true)
        articlesListViewModel.isSearchVisible = false
        articlesListViewModel.searchString = ""
        searchBar.text = ""
        
        removeRecentScreen()
    }
    
    func removeRecentScreen() {
        if recentViewController != nil {
            recentViewController?.remove()
            recentViewController = nil
        }
    }
    
    func showRecentScreen() {
        recentViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecentSearchViewController") as? RecentSearchViewController
        recentViewController?.viewModel = articlesListViewModel
        
        self.add(recentViewController!, frame: containerView.frame)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ShowArticleDetailSegue" {
            
            // Show article detail
            let destination = segue.destination as? ArticleDetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            destination?.articleViewModel = getArticleViewModel(at: indexPath!)
            
            if articlesListViewModel.isSearchVisible && !articlesListViewModel.searchString.isEmpty {
                // Save recent search
                articlesListViewModel.saveSearchTerm(searchTerm: articlesListViewModel.searchString)
            }
        }
    }
}

extension ArticlesListViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesListViewModel.filteredArticleViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCellIdentifier") as! ArticleTableViewCell
        
        let articleViewModel : ArticleViewModel = articlesListViewModel.filteredArticleViewModels[indexPath.row]
        
        cell.titleLabel.text = articleViewModel.title
        cell.subTitleLabel.text = articleViewModel.snippet
        cell.dateLabel.text = articleViewModel.formattedDateString
        cell.dateImageView.image = articleViewModel.dateImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if articlesListViewModel.isSearchVisible {
            return
        }
        
        let lastElement = articlesListViewModel.filteredArticleViewModels.count - 1
        if !articlesListViewModel.loadingData && indexPath.row == lastElement {
            currentPageNumber += 1
            fetchArticles()
        }
    }
}

extension ArticlesListViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if articlesListViewModel.isSearchVisible {
            return searchBar
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if articlesListViewModel.isSearchVisible {
            return 44.0
        }
        
        return 0.0
    }
}

extension ArticlesListViewController : UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        closeSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        articlesListViewModel.searchString = searchText
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        articlesListViewModel.searchFocused = true
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension ArticlesListViewController : ArticlesListViewModelDelegate {
    
    func showError(error: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            
            let retryAction = UIAlertAction(title: "Retry", style: .default) { (UIAlertAction) in
                self.fetchArticles()
            }
            
            alertController.addAction(retryAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showLoader(show: Bool) {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = !show
        }
    }
    
    func showRecentScreen(show: Bool) {
        
        if show {
            removeRecentScreen()
            showRecentScreen()
            
        } else {
            removeRecentScreen()
        }
    }
    
    func updateSearchFieldWithText(search: String) {
        searchBar.text = search
    }
}
