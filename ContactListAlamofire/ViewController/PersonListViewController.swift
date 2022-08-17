//
//  PersonListViewController.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

import UIKit

class PersonListViewController: UITableViewController {

    private var contacts: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 60
        downloadData()
        setupRefreshControl()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let personalVC = segue.destination as! PersonListDetailsViewController
        personalVC.result = sender as? User
    }
}

// MARK: - UITAbleViewDataSource
extension PersonListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = contacts[indexPath.row]
        content.text = contact.name.first
        content.secondaryText = contact.name.last
        
        NetworkManager.shared.fetchData(from: contact.picture.thumbnail) { result in
            switch result {
            case .success(let imageData):
                content.image = UIImage(data: imageData)
                cell.contentConfiguration = content
            case .failure(let error):
                print(error)
            }
        }
        
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: - UITableViewDelegate
extension PersonListViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentUser = contacts[indexPath.row]
        performSegue(withIdentifier: Segues.showContact.rawValue, sender: currentUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Private Methods
extension PersonListViewController {
    @objc private func downloadData() {
        NetworkManager.shared.fetchUsers { result in
            switch result {
            case .success(let contacts):
                self.contacts = contacts
                self.tableView.reloadData()
                if self.refreshControl != nil {
                    self.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(downloadData), for: .valueChanged)
    }
}

