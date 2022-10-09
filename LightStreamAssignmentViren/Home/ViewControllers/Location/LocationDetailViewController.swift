//
//  LocationDetailViewController.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import UIKit

class LocationDetailViewController: UIViewController {
    let vm: LocationDetailViewModel
    
    let tableView = UITableView()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let dimensionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    private let noResidentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Looks like it's a dead planet, No one lives here."
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 8.0
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vm.title()
        setupViews()
        populateData()
        fetResidentsForLocation()
    }
    
    init(_ vm: LocationDetailViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: SetUP View ane Populating
extension LocationDetailViewController {
    private func setupViews() {
        view.backgroundColor = .white
        tableView.register(CharacterInfoTableViewCell.self, forCellReuseIdentifier: CharacterInfoTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(dimensionLabel)
        
        view.addSubview(stackView)
        view.addSubview(noResidentsLabel)
        view.addSubview(tableView)
        
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 8,
                         paddingLeft: 8,
                         paddingRight: 8
        )
        
        noResidentsLabel.anchor(top: stackView.bottomAnchor,
                                left: view.safeAreaLayoutGuide.leftAnchor,
                                right: view.safeAreaLayoutGuide.rightAnchor,
                                paddingTop: 16,
                                paddingLeft: 8,
                                paddingRight: 8
        )
        
        tableView.anchor(top: stackView.bottomAnchor,
                         left: view.safeAreaLayoutGuide.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.safeAreaLayoutGuide.rightAnchor,
                         paddingTop: 16
        )
    }
    
    private func populateData() {
        nameLabel.text = vm.nameLabelText()
        typeLabel.text = vm.typeLabelText()
        dimensionLabel.text = vm.dimensionLabelText()
        manageNoResidentsLabelState()
    }
    
    private func manageNoResidentsLabelState() {
        if vm.residents.count == 0 {
            noResidentsLabel.isHidden = false
            tableView.isHidden = true
        } else {
            noResidentsLabel.isHidden = true
            tableView.isHidden = false
        }
    }
    
    private func fetResidentsForLocation() {
        vm.fetchCharactersForLocation { [weak self] in
            self?.manageNoResidentsLabelState()
            self?.tableView.reloadData()
        }
    }
}

extension LocationDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoTableViewCell.identifier, for: indexPath) as! CharacterInfoTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.configure(vm.resident(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = CharacterDetailViewModel(vm.resident(at: indexPath))
        let vc = CharacterDetailViewController(vm: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
