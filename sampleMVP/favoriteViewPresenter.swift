//
//  favoriteViewPresenter.swift
//  sampleMVP
//
//  Created by USER on 2020/04/29.
//  Copyright © 2020 USER. All rights reserved.
//

import Foundation
import UIKit
import GithubKit

protocol FavoritePresenter: class {
    var view: FavoriteView? { get set }
    var numberOfFavorites: Int { get }
    func addFavorite(_ repository: Repository)
    func removeFavorite(_ repository: Repository)
    func favoriteRepository(at index: Int) -> Repository
    func showFavoriteRepository(at index: Int)
    func contains(_ repository: Repository) -> Bool
}

 class FavoriteViewPresenter: FavoritePresenter {
    weak var view: FavoriteView?

    var numberOfFavorites: Int {
        return model.favorites.count
    }

    private let model = FavoriteModel()

    init() {
        self.model.delegate = self
    }
    
    func favoriteRepository(at index: Int) -> Repository {
        return model.favorites[index]
    }
    
    func addFavorite(_ repository: Repository) {
        model.addFavorite(repository)
    }
    
    func removeFavorite(_ repository: Repository) {
        model.removeFavorite(repository)
    }
    
    func contains(_ repository: Repository) -> Bool {
        return model.favorites.lazy.index { $0.url == repository.url } != nil
    }
    
    func showFavoriteRepository(at index: Int) {
        let repository = model.favorites[index]
        view?.showRepository(with: repository)
    }
}

extension FavoriteViewPresenter: FavoriteModelDelegate {
    func favoriteDidChange() {
        view?.reloadData()
    }
}
