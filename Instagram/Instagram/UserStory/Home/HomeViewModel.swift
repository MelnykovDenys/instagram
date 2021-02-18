//
//  HomeViewModel.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import Foundation
import UIKit
import RxSwift

protocol HomeViewModelDelegate: class {
    func postsDidFetchSuccess()
    func postsDidFetchFail()
}

class HomeViewModel {
    
    private let provider = OnlineProvider<PostAPI>()
    private let disposeBag = DisposeBag()
    
    weak var delegate: HomeViewModelDelegate?
    
    var collectionViewDataSource = [PhotoURL]()
    
    private(set) var posts = [Post]()
    
    func getPosts() {
        provider.rx.request(.getPosts)
            .map([Post].self)
            .subscribe { [weak self] posts in
                self?.posts = posts
                self?.delegate?.postsDidFetchSuccess()
            } onError: { [weak self] _ in
                self?.delegate?.postsDidFetchFail()
            }.disposed(by: disposeBag)

    }
}
