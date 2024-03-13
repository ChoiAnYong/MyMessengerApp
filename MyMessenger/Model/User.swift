//
//  User.swift
//  MyMessenger
//
//  Created by 최안용 on 3/12/24.
//

import Foundation

struct User {
    var id: String
    var name: String
    var phoneNumber: String?
    var profileURL: String?
    var description: String?
}

extension User {
    static var stub1: User {
        .init(id: "user1_id", name: "최안용")
    }
    
    static var stub2: User {
        .init(id: "user2_id", name: "이광혁")
    }
}
