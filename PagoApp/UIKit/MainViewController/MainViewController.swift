//
//  MainViewController.swift
//  PagoApp
//
//  Created by Sergiu Corbu on 15.07.2022.
//

import UIKit

class MainViewController: UITableViewController {
    
    let viewModel: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .aliceBlue
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: ContactCell.cellReuseIdentifier)
        tableView.estimatedRowHeight = 94
        tableView.contentInset.top = 12
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addRefreshControll()
        viewModel.tableView = tableView
    }
    
    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Contacte"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .left
        navigationItem.titleView = titleLabel
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "addContact-icon"),
            style: .plain,
            target: self,
            action: #selector(addContact)
        )
    }
    
    private func addRefreshControll() {
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    @objc func reloadData() {
        Task(priority: .userInitiated) {
            tableView.refreshControl?.beginRefreshing()
            await viewModel.fetchContacts()
            tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc
    private func addContact() {
        navigationController?.pushViewController(AddContactViewController(contact: nil), animated: true)
    }
}

extension MainViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UILabel()
        headerView.text = "CONTACTELE MELE"
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.font = .systemFont(ofSize: 13, weight: .semibold)
        headerView.textColor = .wildBlueYonder
        return headerView
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.contacts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = viewModel.contacts[indexPath.row]
        navigationController?.pushViewController(AddContactViewController(contact: contact), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactCell.cellReuseIdentifier, for: indexPath) as! ContactCell
        cell.contact = viewModel.contacts[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.0
    }
}

extension BackendService {
    
    static func loadContacts() async throws -> [Contact] {
        return try await httpClient.create(request: .get, path: "users").decodedResponse()
    }
}
