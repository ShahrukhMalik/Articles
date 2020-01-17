//
//  ArticleDetailViewController.swift
//  Articles
//
//  Created by Shahrukh Malik on 17/01/2020.
//  Copyright © 2020 Shahrukh. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var mainImageView: DownloaderImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    
    
    // MARK: - Properties
    
    var articleViewModel : ArticleViewModel!
    
    
    // MARK :- UIViewController methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.configureViewUsingViewModel(viewModel: articleViewModel)
    }
    
    
    // MARK: - Private methods
    
    func configureViewUsingViewModel(viewModel: ArticleViewModel) {
        self.title = viewModel.screenTitle
        
        self.titleLabel.text = viewModel.title
        self.subTitleLabel.text = viewModel.snippet
        self.abstractLabel.text = viewModel.formattedDateString
        self.mainImageView.loadImageUsingUrlString(urlString: viewModel.imageURLString)
    }
}
