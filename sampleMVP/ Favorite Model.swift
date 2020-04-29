//
//   Favorite Model.swift
//  sampleMVP
//
//  Created by USER on 2020/04/29.
//  Copyright © 2020 USER. All rights reserved.
//

import GithubKit

protocol FavoriteModelDelegate: AnyObject {
    func favoriteDidChange()
}

extension FavoriteModelDelegate {
    func favoriteDidChange() {}
}

final class FavoriteModel {
    private(set) var favorites: [Repository] = [] {
        didSet {
            delegate?.favoriteDidChange()
        }
    }
    
    weak var delegate: FavoriteModelDelegate?
    
    func addFavorite(_ repository: Repository) {
        if favorites.lazy.index(where: { $0.url == repository.url }) != nil {
            return
        }
        favorites.append(repository)
    }
    
    func removeFavorite(_ repository: Repository) {
        guard let index = favorites.lazy.index(where: { $0.url == repository.url }) else {
            return
        }
        favorites.remove(at: index)
    }
}

