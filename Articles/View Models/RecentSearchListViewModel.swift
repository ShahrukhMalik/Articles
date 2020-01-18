//
//  RecentSearchListViewModel.swift
//  Articles
//
//  Created by Shahrukh Malik on 18/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import Foundation

class RecentSearchListViewModel : NSObject {
    
    var repo: RecentSearchRepository!
    
    var title: String {
        return "Recent Search"
    }
    
    var reloadTableViewClosure: ((Any?)->())?
    
    var recentSearchViewModels: [RecentSearchViewModel] = [RecentSearchViewModel]() {
        didSet {
            self.reloadTableViewClosure?(nil)
        }
    }
    
    init(rep: RecentSearchRepository) {
        repo = rep
    }
    
    func fetchRecentSearches() {
        if let recentSearchModels = repo.fetchRecentSearches() {
            convertRecentSearchModelListToRecentSearchViewModelList(recentSearchModelList: recentSearchModels)
        }
    }
    
    func convertRecentSearchModelListToRecentSearchViewModelList(recentSearchModelList : [RecentSearchModel]) {
        var processedViewModelArray = [RecentSearchViewModel]()
        
        for item in recentSearchModelList {
            let viewModel = RecentSearchViewModel(aTerm: item.term, aDate: item.date)
            processedViewModelArray.append(viewModel)
        }
        
        recentSearchViewModels = processedViewModelArray
    }
    
    func sendSelectedTerm(term: String) {
        // Notification fired which is observed by ArticlesListViewModel to update the search string
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SearchTermTapped"), object: self, userInfo: ["Search":term])
    }
}
