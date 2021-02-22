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
    var user = User(id: "", nameImage: "user.png", name: nil, birthday: nil, place: nil, listIdFriends: nil, nameBackgroundImage: "background.jpg")
    
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
            "background": user.nameBackgroundImage ?? "background.jpg"
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func setDataFriend(id: String, listFriend: [String]) {
        db.collection("users").document(id).setData([
            "listIdFriends": listFriend
        ], merge: true)
    }
    
    func setDataPost(data: Post) {
        db.collection("posts").document().setData([
            "id": data.id ,
            "listImage": data.listImage ?? [""],
            "content": data.content ?? ""
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
                            case "background":
                            self.user.nameBackgroundImage = values as? String
                            default:
                                break
                            }
                        }
                    }
                }
        }
    }
    
    func getUserFromName(name: String,completionHandler: @escaping (_ result: [User]) -> ()) {
        var dataSources = [User]()
        db.collection("users").whereField("name", isEqualTo: name)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        var result = User()
                        for (key, values) in document.data() {
                            switch key {
                            case "birthday":
                                result.birthday = values as? String
                            case "place":
                                result.place = values as? String
                            case "id":
                                result.id = values as? String
                            case "listIdFriends":
                                result.listIdFriends = values as? [String]
                            case "name":
                                result.name = values as? String
                            case "avatar":
                                result.nameImage = values as? String
                            case "background":
                                result.nameBackgroundImage = values as? String
                            default:
                                break
                            }
                        }
                        dataSources.append(result)
                    }
                    completionHandler(dataSources)
                }
        }
    }
    
    func getPostFromId(id: String, completionHandler: @escaping (_ result: [Post]) -> ()) {
        var dataSources = [Post]()
        db.collection("posts").whereField("id", isEqualTo: id)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        var data = Post(id: id)
                        for (key, values) in document.data() {
                            switch key {
                            case "id":
                                data.id = values as! String
                            case "listImage":
                                data.listImage = values as? [String]
                            case "content":
                                data.content = values as? String
                            default:
                                break
                            }
                        }
                        dataSources.append(data)
                    }
                    completionHandler(dataSources)
                }
        }
    }
}
