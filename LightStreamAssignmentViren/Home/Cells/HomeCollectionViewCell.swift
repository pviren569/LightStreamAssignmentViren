//
//  HomeCollectionViewCell.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/8/22.
//

import Foundation
import UIKit

final class HomeCollectionViewCell: UICollectionViewCell {
    private let optionImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = Constants.contentViewCornerRadius
        contentView.backgroundColor = .yellow.withAlphaComponent(0.4)
        
        contentView.layer.cornerRadius = 15
        
        contentView.addSubview(optionImageView)
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayouts() {
        optionImageView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor,
                               left: contentView.safeAreaLayoutGuide.leftAnchor,
                               right: contentView.safeAreaLayoutGuide.rightAnchor,
                               paddingLeft: Constants.horizontalPadding,
                               paddingRight: Constants.horizontalPadding,
                               height: Constants.imageHeight
        )
        
        titleLabel.anchor(top: optionImageView.bottomAnchor,
                          left: contentView.safeAreaLayoutGuide.leftAnchor,
                          right: contentView.safeAreaLayoutGuide.rightAnchor,
                          paddingTop:  Constants.verticalpadding,
                          paddingLeft: Constants.horizontalPadding,
                          paddingRight: Constants.horizontalPadding
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with option: HomeViewOption) {
        optionImageView.image = UIImage(named: option.imageName)
        titleLabel.text = option.name
    }
}

extension HomeCollectionViewCell {
    private enum Constants {
        // MARK: contentView layout constants
        static let contentViewCornerRadius: CGFloat = 4.0
        
        // MARK: profileImageView layout constants
        static let imageHeight: CGFloat = 180.0
        
        // MARK: Generic layout constants
        static let horizontalPadding: CGFloat = 16.0
        static let verticalpadding: CGFloat = 8.0
        static let descriptionVerticalPadding: CGFloat = 8.0
    }
}


extension HomeCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
