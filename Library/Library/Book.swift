//
//  Book.swift
//  Library
//
//  Created by Tennant Shaw on 5/19/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import Foundation


class Book {
    // MARK: - Properties
    var checkedOut: Bool
    var title: String
    var author: String
    var genre: String
    var user: User?
    
    static var checkedOutKey: String = "checkedOut"
    static var titleKey: String = "title"
    static var authorKey: String = "author"
    static var genreKey: String = "genre"
    static var userKey: String = "user"
    
    // MARK: - Method
    static func array(json: [[String: Any]]) -> [Book]? {
        let back = json.flatMap(Book.init(json:))
        guard back.count == json.count else {
            return nil
        }
        return back
    }
    
    // MARK: - Initializers
    init(checkedOut: Bool, title: String, author: String, genre: String, user: User?) {
        self.checkedOut = checkedOut
        self.title = title
        self.author = author
        self.genre = genre
        self.user = user
    }
    
    convenience init?(json: [String:Any]) {
        guard let checkedOut = json[Book.checkedOutKey] as? Bool,
            let title = json[Book.titleKey] as? String,
            let author = json[Book.authorKey] as? String,
            let genre = json[Book.genreKey] as? String else {
                return nil
        }
        let userData = json[Book.userKey] as? [String:Any]
        let user = userData.flatMap(User.init(json:))
        self.init(checkedOut: checkedOut, title: title, author: author, genre: genre, user: user)
    }
    
}
