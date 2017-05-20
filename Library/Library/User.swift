//
//  User.swift
//  Library
//
//  Created by Tennant Shaw on 5/19/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation


class User {
    
    // MARK: - Properties
    var userName: String
    var firstName: String
    var lastName: String
    var id: Int
    
    static var userNameKey: String = "userName"
    static var firstNameKey: String = "firstName"
    static var lastNameKey: String = "lastName"
    static var idKey: String = "id"
    
    
    // MARK: - Initializers
    init(userName: String, firstName: String, lastName: String, id: Int) {
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
    
    convenience init?(json: [String:Any]) {
       guard let userName = json[User.userNameKey] as? String,
             let firstName = json[User.firstNameKey] as? String,
             let lastName = json[User.lastNameKey] as? String,
        let id = json[User.idKey] as? Int else {
            return nil
        }
        self.init(userName: userName, firstName: firstName, lastName: lastName, id: id)
    }
    
}
