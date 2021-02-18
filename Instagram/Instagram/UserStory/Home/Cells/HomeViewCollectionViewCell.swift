//
//  HomeViewCollectionViewCell.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import UIKit

final class HomeViewCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: HomeViewCollectionViewCell.self)
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func setupLayout() {
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(image: UIImage?) {
        imageView.image = image
    }
}
