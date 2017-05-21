//
//  ViewController.swift
//  Library
//
//  Created by Tennant Shaw on 5/3/17.
//  Copyright © 2017 Tennant Shaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    var library = [Book]()
    var bookWorm = [User]()
    var index = 0 {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var checkedOutStatusLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func previousButton(_ sender: UIButton) {
        if index > 0 {
            index -= 1
        }
        
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        if index < library.count - 1 {
            index += 1
        }
    }
    
    //MARK: - Methods
    func fetchJSONData() {
        guard let url = URL(string: "https://tiy-todo-angular.herokuapp.com/get-all-books.json") else {
            fatalError("failed to create URL")
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, responce, error) in
            if error != nil {
                print("error")
                return
            } else {
                if let data = data {
                    self.library = self.parseJsonData(data: data)
                    OperationQueue.main.addOperation {
                        self.updateUI()
                    }
                }
            }
        })
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Book] {
        
        var books = [Book]()
        
        do {
            let jsonResult = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
            guard let book = Book.array(json: jsonResult!) else {
                fatalError("Bad thing happened here")
            }
            books = book
        }
        return books
    }
    
    func parseJSONDataForUser(data: Data) -> [User] {
        var users = [User]()
        
        do {
            let jsonResult = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
            guard let user = User.array(json: jsonResult!) else {
                fatalError("Error parsing user data from JSON")
            }
            users = user
        }
        return users
    }
    
    func updateUI() {
        self.titleLabel.text = "\(self.library[self.index].title)"
        self.authorLabel.text = "\(self.library[self.index].author)"
        self.genreLabel.text = "\(self.library[self.index].genre)"
        if self.library[self.index].user == nil {
            self.checkedOutStatusLabel.text = "This book is available for checkout."
            self.userLabel.text = ""
        } else {
            self.checkedOutStatusLabel.text = "Checked out by:"
            self.userLabel.text = "\(self.library[self.index].user!.userName)" // "dev@tiy.com"
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSONData()
    }
}

