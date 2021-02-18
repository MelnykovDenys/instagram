//
//  HomeViewController.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let contentView = HomeView()
    private let viewModel = HomeViewModel()
        
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = UIImageView(image: R.image.logo())
        viewModel.delegate = self
        viewModel.getPosts()
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
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
        ImageLoader.shared.downloadImage(with: post.iconURL) { profileImage in
            cell.configure(post: post, profileImage: profileImage)
            self.viewModel.collectionViewDataSource = post.photosURL
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
        }
        
        return cell
    }
}

// MARK: -UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCollectionViewCell.identifier, for: indexPath) as? HomeViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        ImageLoader.shared.downloadImage(with: viewModel.collectionViewDataSource[indexPath.row].photo) { photo in
            cell.configure(image: photo)
        }
        return cell
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: collectionView.frame.height)
    }
}

// MARK: -HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    
    func postsDidFetchSuccess() {
        contentView.tableView.reloadData()
        print(viewModel.posts)
    }
    
    func postsDidFetchFail() {
        debugPrint("getPosts request did fail")
    }
}
