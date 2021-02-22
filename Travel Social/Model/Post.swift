//
//  Post.swift
//  Travel Social
//
//  Created by Phan Nguyen on 25/01/2021.
//

import Foundation

struct Post {
    var id: String
    var content: String?
    var listImage: [String]?
    var date: String?
    //var listComment: [Comment]?
}

struct Comment {
    var id: String
    var content: String
}
