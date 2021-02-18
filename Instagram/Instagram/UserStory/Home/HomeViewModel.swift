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
    func postsDidFetchFail(with error: String)
}

class HomeViewModel {
    
    private let provider = OnlineProvider<PostAPI>()
    private let disposeBag = DisposeBag()
    
    private(set) var posts = [Post]()

    weak var delegate: HomeViewModelDelegate?
    
    func getPosts() {
        provider.rx.request(.getPosts)
            .map([Post].self)
            .subscribe { [weak self] posts in
                self?.posts = posts
                self?.delegate?.postsDidFetchSuccess()
            } onError: { [weak self] error in
                self?.delegate?.postsDidFetchFail(with: error.localizedDescription)
            }.disposed(by: disposeBag)
    }
}
