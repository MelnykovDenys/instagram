//
//  HomeViewController.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let contentView = HomeView()
    private let viewModel = HomeViewModel()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        contentView.tableView.dataSource = self
        setupNavigationBar()
        getPosts()
        
    }
    
    private func setupNavigationBar() {
        self.navigationItem.titleView = UIImageView(image: R.image.logo())
        navigationItem.leftBarButtonItem = UIBarButtonItem.instaBarButton(with: Images.cameraIcon())
        navigationItem.rightBarButtonItem = UIBarButtonItem.instaBarButton(with: Images.mailIcon())
    }
    
    private func getPosts() {
        contentView.showActivityIndicator()
        viewModel.getPosts()
    }
}

// MARK: -UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableViewCell.identifier) as? HomeViewTableViewCell else {
            return UITableViewCell()
        }
        let post = viewModel.posts[indexPath.row]
        cell.configure(post: post)
        return cell
    }
}

// MARK: -HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func postsDidFetchSuccess() {
        contentView.hideActivityIndicator()
        contentView.tableView.reloadData()
    }
    
    func postsDidFetchFail(with error: String) {
        contentView.hideActivityIndicator()
        AlertService.shared.showErrorAlert(with: error, on: self)
    }
}
