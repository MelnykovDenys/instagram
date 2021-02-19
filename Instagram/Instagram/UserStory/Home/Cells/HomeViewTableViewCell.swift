//
//  HomeViewTableViewCell.swift
//  Instagram
//
//  Created by Denys Melnykov on 18.02.2021.
//

import UIKit

final class HomeViewTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: HomeViewTableViewCell.self)
    
    private let profileIconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let locationLabel = UILabel()
    private let likedLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let hoursLabel = UILabel()
    private let pageControl = UIPageControl()
    
    private var photosURL = [String]()
    
    private lazy var collectionView: UICollectionView = {
        let configuredCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        configuredCollectionView.collectionViewLayout = layout
        configuredCollectionView.showsHorizontalScrollIndicator = false
        configuredCollectionView.isPagingEnabled = true
        configuredCollectionView.bounces = false
        configuredCollectionView.register(HomeViewCollectionViewCell.self, forCellWithReuseIdentifier: HomeViewCollectionViewCell.identifier)
        configuredCollectionView.backgroundColor = .white
        configuredCollectionView.delegate = self
        configuredCollectionView.dataSource = self
        return configuredCollectionView
    }()
    
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
        
        contentView.addSubview(profileIconImageView)
        profileIconImageView.snp.makeConstraints {
            $0.size.equalTo(40)
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(5)
        }
        
        nameLabel.font = .boldSystemFont(ofSize: 15)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileIconImageView.snp.trailing).offset(5)
            $0.top.equalTo(profileIconImageView)
            $0.trailing.equalToSuperview()
        }
        
        locationLabel.font = Fonts.sfuiTextRegular(size: 10)
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
        }
        
        hoursLabel.textColor = Colors.lightGray()
        hoursLabel.font = .systemFont(ofSize: 10)
        contentView.addSubview(hoursLabel)
        hoursLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(5)
            $0.bottom.lessThanOrEqualToSuperview().inset(20).priority(.low)
        }
    }
    
    func configure(post: Post) {
        photosURL = post.photosURL
        collectionView.reloadData()
        
        nameLabel.text = post.name
        locationLabel.text = post.location
        likedLabel.attributedText = Localizable.likedBy(post.likedPersonList(), String(post.likedCount)).detectAttributes()
        descriptionLabel.attributedText = Localizable.profileComment(post.name, post.description).detectAttributes()
        pageControl.isHidden = post.isHiddenPageControl
        pageControl.numberOfPages = post.photosURL.count
        hoursLabel.text = post.hours
        
        ImageLoader.shared.downloadImage(with: post.iconURL) { profileImage in
            self.profileIconImageView.image = profileImage
        }
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension HomeViewTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosURL.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCollectionViewCell.identifier, for: indexPath) as? HomeViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        ImageLoader.shared.downloadImage(with: photosURL[indexPath.row]) { photo in
            cell.configure(image: photo)
        }
        return cell
    }
    
// MARK: - PageControl detect
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView == collectionView else { return }
        pageControl.currentPage = Int(targetContentOffset.pointee.x / frame.width)
    }
}

// MARK: -UICollectionViewDelegateFlowLayout
extension HomeViewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: collectionView.frame.height)
    }
}
