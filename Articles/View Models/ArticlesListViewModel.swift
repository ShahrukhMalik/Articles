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
}

class ArticlesListViewModel : NSObject {
    
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
    
    
    var repo:ArticleRemoteRepository = ArticleRemoteRepository()
    
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
    
    
    // MARK: - Private methods
    
    func filterArticleViewModelWithText(searchText: String) {
        var filtered = filteredArticleViewModels
        
        if searchText.isEmpty {
            filtered = self.articleViewModels
            
        } else {
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
                imageUrlString = APIURLPrefix + item.multimedia[0].url
            }
            
            let viewModel = ArticleViewModel(title: item.headline.main,
                                             snippet: item.snippet,
                                             publishedDate: item.pubDate,
                                             imageURLString: imageUrlString)
            
            processedViewModelArray.append(viewModel)
        }
        
        
        self.articleViewModels.append(contentsOf: processedViewModelArray)
    }
}
