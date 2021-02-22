//
//  UserViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 26/01/2021.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSources = [Post]()
    var dataUser = DataManager.shared.user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dataUser = DataManager.shared.user
        tableView.reloadData()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InfoUserTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoUserTableViewCell")
        tableView.register(UINib(nibName: "ListFriendTableViewCell", bundle: nil), forCellReuseIdentifier: "ListFriendTableViewCell")
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    func setDataPost() {
        DataManager.shared.getPostFromId(id: DataManager.shared.user.id!) { result in
            self.dataSources = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension UserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 440
        case 1:
            return 100
        default:
            return 500
        }
    }
    
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return dataSources.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoUserTableViewCell", for: indexPath) as? InfoUserTableViewCell else { return InfoUserTableViewCell() }
            cell.cellDelegate = self
            cell.selectionStyle = .none
            cell.setData(item: dataUser)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListFriendTableViewCell", for: indexPath) as? ListFriendTableViewCell else { return ListFriendTableViewCell() }
            cell.selectionStyle = .none
            cell.cellDelegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return PostTableViewCell() }
            return cell
        }
    }
    
}

extension UserViewController: InfoUserTableViewCellDelegate {
    func pushViewController(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UserViewController: ListFriendTableViewCellDelegate {
    func showListFriend(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

