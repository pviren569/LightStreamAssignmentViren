//
//  LocationInfoTableViewCell.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import UIKit

class LocationInfoTableViewCell: UITableViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(typeLabel)
        
        
        nameLabel.anchor(top: topAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingTop: 8,
                         paddingLeft: 8,
                         paddingRight: 8
        )
        typeLabel.anchor(top: nameLabel.bottomAnchor,
                         left: leftAnchor,
                         bottom: bottomAnchor,
                         right: rightAnchor,
                         paddingTop: 8,
                         paddingLeft: 8,
                         paddingBottom: 8,
                         paddingRight: 8)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(_ location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
    }
}

extension LocationInfoTableViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
