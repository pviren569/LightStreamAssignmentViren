//
//  LocationTableViewController.swift
//  LightStreamAssignmentViren
//
//  Created by Patel, Viren on 10/9/22.
//

import UIKit

class LocationTableViewController: UITableViewController {
    let vm = LocationTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Locations"
        tableView.register(LocationInfoTableViewCell.self, forCellReuseIdentifier: LocationInfoTableViewCell.identifier)
        fetchData()
    }
    
    func fetchData() {
        vm.fetchLocations { [weak self] error in
            if let error = error {
                self?.presentAlert(title: "Error", message: error.localizedDescription)
                print("LocationTableViewController.fetchData.Error:: \(error)")
            } else {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationInfoTableViewCell.identifier, for: indexPath) as! LocationInfoTableViewCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.configure(vm.location(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vm = LocationDetailViewModel(vm.location(at: indexPath))
        let vc = LocationDetailViewController(vm)
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
