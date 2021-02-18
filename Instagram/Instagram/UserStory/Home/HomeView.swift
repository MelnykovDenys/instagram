//
//  HomeView.swift
//  Instagram
//
//  Created by Denys Melnykov on 17.02.2021.
//

import UIKit

final class HomeView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        backgroundColor = Colors.white()
        
        tableView.register(HomeViewTableViewCell.self, forCellReuseIdentifier: HomeViewTableViewCell.identifier)
        tableView.bounces = false
        addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.white()
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
