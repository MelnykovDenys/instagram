//
//  HomeViewTableViewCell.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import UIKit

class HomeViewTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: HomeViewTableViewCell.self)
    
    lazy var collectionView: UICollectionView = {
        let configuredCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        configuredCollectionView.collectionViewLayout = layout
        configuredCollectionView.showsHorizontalScrollIndicator = false
        configuredCollectionView.isPagingEnabled = true
        configuredCollectionView.bounces = false
        configuredCollectionView.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: HomeViewCollectionViewCell.identifier)
        configuredCollectionView.backgroundColor = .white
        return configuredCollectionView
    }()
    
    private let profileIconImageView = UIImageView()
    
    private let nameLabel = UILabel()
    private let locationLabel = UILabel()
    private let likedLabel = UILabel()
    private let descriptionLabel = UILabel()
    
    private let pageControl = UIPageControl()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileIconImageView.image = nil
    }
    
    private func setupLayout() {
        
        selectionStyle = .none
        
        profileIconImageView.contentMode = .scaleAspectFit
        profileIconImageView.setRounded()
        contentView.addSubview(profileIconImageView)
        profileIconImageView.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(5)
        }
        
        nameLabel.font = Fonts.sfuiTextMedium(size: 12)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileIconImageView.snp.trailing).offset(5)
            $0.top.equalTo(profileIconImageView)
            $0.trailing.equalToSuperview()
        }
        
        locationLabel.font = Fonts.sfuiTextRegular(size: 12)
        contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom)
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalTo(profileIconImageView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.65)
        }
        
        
        let healthButton = UIButton()
        contentView.addSubview(healthButton)
        healthButton.setImage(Images.heartIcon(), for: .normal)
        healthButton.snp.makeConstraints {
            $0.leading.equalTo(profileIconImageView)
            $0.top.equalTo(collectionView.snp.bottom).offset(15)
            $0.size.equalTo(30)
        }
        
        let commentsButton = UIButton()
        contentView.addSubview(commentsButton)
        commentsButton.setImage(Images.commentIcon(), for: .normal)
        commentsButton.snp.makeConstraints {
            $0.leading.equalTo(healthButton.snp.trailing).offset(10)
            $0.top.size.equalTo(healthButton)
        }
        
        let mailButton = UIButton()
        contentView.addSubview(mailButton)
        mailButton.setImage(Images.mailIcon(), for: .normal)
        mailButton.snp.makeConstraints {
            $0.leading.equalTo(commentsButton.snp.trailing).offset(10)
            $0.size.top.equalTo(commentsButton)
        }
        
        pageControl.pageIndicatorTintColor = Colors.lightGray()
        pageControl.currentPageIndicatorTintColor = Colors.tagColor()
        contentView.addSubview(pageControl)
        pageControl.snp.makeConstraints {
            $0.centerY.equalTo(mailButton)
            $0.centerX.equalToSuperview()
        }
        
        let bookMarkButton = UIButton()
        bookMarkButton.setImage(Images.bookmarkIcon(), for: .normal)
        contentView.addSubview(bookMarkButton)
        bookMarkButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(15)
            $0.top.size.equalTo(mailButton)
        }
        
        likedLabel.numberOfLines = 0
        likedLabel.font = Fonts.sfuiTextRegular(size: 12)
        contentView.addSubview(likedLabel)
        likedLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(mailButton.snp.bottom)
        }
        
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(likedLabel.snp.bottom).offset(15)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(post: Post, profileImage: UIImage?) {
        
        nameLabel.text = post.name
        locationLabel.text = post.location
        likedLabel.text = Localizable.likedBy(post.likedPersonList(), String(post.likedCount))
        descriptionLabel.text = post.description
        pageControl.numberOfPages = post.numberOfPage
        profileIconImageView.image = profileImage
        collectionView.reloadData()
    }
}
