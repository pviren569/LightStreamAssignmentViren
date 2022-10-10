//
//  CharacterInfoTableViewCell.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import UIKit

class CharacterInfoTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 8.0
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(characterImage)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        contentView.addSubview(stackView)
        
        characterImage.layer.cornerRadius = 15
        
        characterImage.anchor(top: topAnchor,
                              left: leftAnchor,
                              bottom: bottomAnchor,
                              paddingTop: 8,
                              paddingLeft: 8,
                              paddingBottom: 8,
                              width: 90
        )
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.anchor(left: characterImage.rightAnchor,
                         paddingLeft: 10
        )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ character: Character) {
        nameLabel.text = character.name
        statusLabel.text = character.status.rawValue
        characterImage.load(urlString: character.image, defaultImage: UIImage(named: "character-image-not-found"))
    }
    
}

extension CharacterInfoTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
