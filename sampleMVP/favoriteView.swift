//
//  ViewController.swift
//  sampleMVP
//
//  Created by USER on 2020/04/28.
//  Copyright © 2020 USER. All rights reserved.
//

import UIKit
import GithubKit


protocol FavoriteView: class {
    func reloadData()
    func showRepository(with repository: Repository)
}


class FavoriteViewController: UIViewController,FavoriteView {
    

    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let presenter: FavoritePresenter
        let dataSource: FavoriteViewDataSource

        init(presenter: FavoritePresenter) {
            self.presenter = presenter
            self.dataSource = FavoriteViewDataSource(presenter: presenter)
            super.init(nibName: FavoriteViewController.className, bundle: nil)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func viewDidLoad() {
            super.viewDidLoad()

            title = "On Memory Favorite"

            presenter.view = self
            dataSource.configure(with: tableView)
        }
        
        func showRepository(with repository: Repository) {
            let repositoryPresenter = RepositoryViewPresenter(repository: repository, favoritePresenter: presenter)
            let vc = RepositoryViewController(presenter: repositoryPresenter)
            navigationController?.pushViewController(vc, animated: true)
        }
        
        func reloadData() {
            tableView?.reloadData()
        }
    }


