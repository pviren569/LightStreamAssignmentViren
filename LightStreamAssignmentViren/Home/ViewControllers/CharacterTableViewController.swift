//
//  CharacterTableViewController.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import UIKit

class CharacterTableViewController: UITableViewController {
    let vm = CharacterTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        tableView.register(CharacterInfoTableViewCell.self, forCellReuseIdentifier: CharacterInfoTableViewCell.identifier)
        fetchData()
    }
    
    func fetchData() {
        vm.fetchCharacters { error in
            if let error = error {
                print("CharacterTableViewController.fetchData.Error:: \(error)")
            } else {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterInfoTableViewCell.identifier, for: indexPath) as! CharacterInfoTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.configure(vm.character(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.characters.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = CharacterDetailViewModel(model: vm.character(at: indexPath))
        let vc = CharacterDetailViewController(vm: vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
