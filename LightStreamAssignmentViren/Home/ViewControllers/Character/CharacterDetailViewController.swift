//
//  CharacterDetailViewController.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    let vm: CharacterDetailViewModel
    
    private let characterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let originLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let lastKnownlocationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.leading
        stackView.spacing = 8.0
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vm.namelabelText()
        setupViews()
        populateData()
    }
    
    init(vm: CharacterDetailViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: SetUP View ane Populating
extension CharacterDetailViewController {
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(characterImage)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(lastKnownlocationLabel)
        stackView.addArrangedSubview(genderLabel)
        
        view.addSubview(stackView)
        
        characterImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                              left: view.safeAreaLayoutGuide.leftAnchor,
                              right: view.safeAreaLayoutGuide.rightAnchor,
                              height: 200
        )
        
        stackView.anchor(top: characterImage.bottomAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 16,
                         paddingLeft: 16,
                         paddingRight: 16
        )
    }
    
    private func populateData() {
        characterImage.load(urlString: vm.characterImageUrlString())
        nameLabel.text = vm.namelabelText()
        statusLabel.text = vm.statusLabelText()
        originLabel.text = vm.originLabelText()
        lastKnownlocationLabel.text = vm.lastKnownlocationLabelText()
        genderLabel.text = vm.genderLabelText()
    }
}
