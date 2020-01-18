//
//  ArticlesListViewModel.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

protocol ArticlesListViewModelDelegate: class {
    func showError(error: String)
    func showLoader(show: Bool)
    func showRecentScreen(show: Bool)
    func updateSearchFieldWithText(search: String)
}

class ArticlesListViewModel : NSObject {
    
    var repo: ArticleRemoteRepository = ArticleRemoteRepository(aServiceApI: ServiceApi(), aCoreDataManager: CoreDataManager())
    
    
    // MARK: - Article List
    
    var delegate: ArticlesListViewModelDelegate?
    
    var loadingData: Bool = false
    
    var screenTitle: String {
        return "Most Popular"
    }
    
    var searchImage: UIImage {
        return UIImage(named: "SearchIcon")!.withRenderingMode(.alwaysTemplate)
    }
    
    var dotImage: UIImage {
        return UIImage(named: "DotsIcon")!.withRenderingMode(.alwaysTemplate)
    }
    
    var isSearchVisible: Bool = false {
        didSet {
            self.reloadTableViewClosure?(nil)
        }
    }
    
    var searchFocused: Bool = false {
        didSet {
            delegate?.showRecentScreen(show: true)
        }
    }
    
    var articleViewModels: [ArticleViewModel] = [ArticleViewModel]() {
        didSet {
            filteredArticleViewModels = articleViewModels
            self.reloadTableViewClosure?(nil)
        }
    }
    
    var filteredArticleViewModels: [ArticleViewModel] = [ArticleViewModel]() {
        didSet {
            self.reloadTableViewClosure?(nil)
        }
    }
    
    var searchString: String = "" {
        didSet {
            self.reloadTableViewWithSearchTextClosure?(searchString)
        }
    }
    
    var error:String = String() {
        didSet {
            delegate?.showError(error: error)
        }
    }
    var reloadTableViewClosure: ((Any?)->())?
    var reloadTableViewWithSearchTextClosure: ((String?)->())?
    
    
    // MARK: - Network Call
    
    func fetchArticles(request:Request.Fetch.ArticleRequest) {
        loadingData = true
        delegate?.showLoader(show: true)
        repo.fetchArticless(request: request, complete: {[weak self] (articleListModel) in
            let articleListModel = articleListModel
            let articleModelsList = articleListModel.response.articles
            self?.convertArticleModelListToArticleViewModelList(articleModelList: articleModelsList)
            self?.loadingData = false
            self?.delegate?.showLoader(show: false)
            
        }) {[weak self] (error) in
            self?.error = error ?? ""
            self?.loadingData = false
            self?.delegate?.showLoader(show: false)
        }
    }
    
    
    // MARK: - Article List Private methods
    
    func searchTermClicked(searchTerm: String) {
        searchString = searchTerm
        delegate?.updateSearchFieldWithText(search: searchTerm)
    }
    
    func filterArticleViewModelWithText(searchText: String) {
        var filtered = filteredArticleViewModels
        
        if searchText.isEmpty {
            filtered = self.articleViewModels
            delegate?.showRecentScreen(show: true)
            
        } else {
            delegate?.showRecentScreen(show: false)
            filtered = self.filteredArticleViewModels.filter {
                $0.title.range(of: searchText, options: .caseInsensitive) != nil
            }
        }
        
        self.filteredArticleViewModels = filtered
    }
    
    func convertArticleModelListToArticleViewModelList(articleModelList : [ArticleModel]) {
        var processedViewModelArray = [ArticleViewModel]()
        
        for item in articleModelList {
            
            var imageUrlString: String? = nil
            
            if item.multimedia.count > 0 {
                imageUrlString = ImageURLPrefix + item.multimedia[0].url
            }
            
            let viewModel = ArticleViewModel(title: item.headline.main,
                                             snippet: item.snippet,
                                             publishedDate: item.pubDate,
                                             imageURLString: imageUrlString)
            
            processedViewModelArray.append(viewModel)
        }
        
        
        self.articleViewModels.append(contentsOf: processedViewModelArray)
    }
    
    // MARK: - Recent searches
    
    var reloadRecentSearchTableViewClosure: ((Any?)->())?
    
    var recentTitle: String {
        return "Recent Search"
    }
    
    var recentSearchViewModels: [RecentSearchViewModel] = [RecentSearchViewModel]() {
        didSet {
            self.reloadRecentSearchTableViewClosure?(nil)
        }
    }
    
    // MARK: - Core Data Call
    
    func fetchRecentSearches() {
        if let recentSearchModels = repo.fetchRecentSearches() {
            convertRecentSearchModelListToRecentSearchViewModelList(recentSearchModelList: recentSearchModels)
        }
    }
    
    func saveSearchTerm(searchTerm: String) {
        repo.insertSearchTerm(searchterm: searchTerm, date: Date())
    }
    
    // MARK: - Recent Search Private methods
    
    func convertRecentSearchModelListToRecentSearchViewModelList(recentSearchModelList : [RecentSearchModel]) {
        var processedViewModelArray = [RecentSearchViewModel]()
        
        for item in recentSearchModelList {
            let viewModel = RecentSearchViewModel(term: item.term, date: item.date)
            processedViewModelArray.append(viewModel)
        }
        
        recentSearchViewModels = processedViewModelArray
    }
}
