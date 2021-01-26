//
//  DataManager.swift
//  Travel Social
//
//  Created by Phan Nguyen on 24/01/2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class DataManager {
    static let shared = DataManager()
    let db = Firestore.firestore()
    var user = User(id: "", nameImage: "user.png", name: nil, birthday: nil, place: nil, listIdFriends: nil)
    
    private init(){
    }
    
    func setDataUser() {
        db.collection("users").document(user.id!).setData([
            "id": user.id ?? "",
            "avatar": user.nameImage ?? "user.png",
            "name": user.name ?? "",
            "birthday": user.birthday ?? "",
            "place": user.place ?? "",
            "listIdFriends": user.listIdFriends ?? [""],
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func getUserFromId(id: String) {
        db.collection("users").whereField("id", isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        for (key, values) in document.data() {
                            switch key {
                            case "birthday":
                                self.user.birthday = values as? String
                            case "place":
                                self.user.place = values as? String
                            case "id":
                                self.user.id = values as? String
                            case "listIdFriends":
                                self.user.listIdFriends = values as? [String]
                            case "name":
                                self.user.name = values as? String
                            case "avatar":
                                self.user.nameImage = values as? String
                            default:
                                break
                            }
                        }
                    }
                }
        }
    }
    
    func searchUser(name: String) -> [User] {
        var listUser = [User]()
        db.collection("user").whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var item = User()
                    for (key, values) in document.data() {
                        switch key {
                        case "birthday":
                            item.birthday = values as? String
                        case "place":
                            item.place = values as? String
                        case "id":
                            item.id = values as? String
                        case "listIdFriends":
                            item.listIdFriends = values as? [String]
                        case "name":
                            item.name = values as? String
                        case "avatar":
                            item.nameImage = values as? String
                        default:
                            break
                        }
                    }
                    listUser.append(item)
                }
            }
        }
        return listUser
    }
}
