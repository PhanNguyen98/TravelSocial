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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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

}

extension UserViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 180
        case 1:
            return 100
        default:
            return 100
        }
    }
    
}

extension UserViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
            cell.setData(item: dataUser)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListFriendTableViewCell", for: indexPath) as? ListFriendTableViewCell else { return ListFriendTableViewCell() }
            cell.cellDelegate = self
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return PostTableViewCell() }
            return cell
        }
    }
    
}

extension UserViewController: InfoUserTableViewCellDelegate {
    func showEditProfile(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UserViewController: ListFriendTableViewCellDelegate {
    func showListFriend(viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
