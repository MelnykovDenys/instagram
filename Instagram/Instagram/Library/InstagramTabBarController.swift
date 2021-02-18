//
//  InstagramTabBarController.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import UIKit

// MARK: - TabItem -
enum TabItem: Int, CaseIterable {
    case home
    case search
    case addPhoto
    case likes
    case myProfile
    
    var image: UIImage? {
        switch self {
        case .home:
            return Images.homeIcon()
        case .search:
            return Images.searchIcon()
        case .addPhoto:
            return Images.selfieIcon()
        case .likes:
            return Images.heartIcon()
        case .myProfile:
            return Images.myPhotoIcon()
        }
    }
    
    var scene: UIViewController.Type {
        switch self {
        case .home:
            return HomeViewController.self
        case .search:
            return SearchViewController.self
        case .addPhoto:
            return SelfieViewController.self
        case .likes:
            return WhatsNewViewController.self
        case .myProfile:
            return MyProfileViewController.self
        }
    }
    
    func navigationController(with viewController: UIViewController) -> UINavigationController {
        let controller: UINavigationController
        switch self {
        case .home, .search, .addPhoto, .likes, .myProfile:
            controller = UINavigationController(rootViewController: viewController)
            controller.delegate = controller as? UINavigationControllerDelegate
        }
        controller.interactivePopGestureRecognizer?.delegate = nil
        return controller
    }
}

extension UITabBarItem {
    fileprivate convenience init(item: TabItem) {
        self.init(title: nil, image: item.image, selectedImage: nil)
    }
}

// MARK: - MainTabBarController -
final class InstagramTabBarController: UITabBarController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupTabBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTabBar() {
        tabBar.tintColor = Colors.black()
        tabBar.isTranslucent = true
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let controllers = TabItem.allCases.map { item -> UIViewController in
            let viewController = item.scene.init()
            viewController.tabBarItem = UITabBarItem(item: item)
            return item.navigationController(with: viewController)
        }
        viewControllers = controllers
    }
}
