//
//  FriendViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 27/01/2021.
//

import UIKit

class FriendViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataUser = User()
    var dataPost = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setDataPost()
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProfileFriendTableViewCell", bundle: nil), forCellReuseIdentifier: "ProfileFriendTableViewCell")
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "PostTableViewCell")
    }
    
    func setDataPost() {
        DataManager.shared.getPostFromId(id: dataUser.id!) { result in
            self.dataPost = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension FriendViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 440
        default:
            return 500
        }
    }
    
}

extension FriendViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return dataPost.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileFriendTableViewCell", for: indexPath) as? ProfileFriendTableViewCell else { return ProfileFriendTableViewCell() }
            cell.selectionStyle = .none
            cell.dataUser = dataUser
            cell.setData(user: dataUser)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else { return PostTableViewCell() }
            cell.selectionStyle = .none
            return cell
        }
    }
    
}

