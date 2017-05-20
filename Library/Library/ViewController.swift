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
    var index = 0
    
    // MARK: - Outlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var genreLabel: UILabel!
    @IBOutlet var checkedOutStatusLabel: UILabel!
    
    
    // MARK: - Actions
    @IBAction func previousButton(_ sender: UIButton) {
        if index > 0 {
            index -= 1
        }
    }
    @IBAction func nextButton(_ sender: UIButton) {
        index += 1
        if index > library.count {
            index = 0
        }
    }
    
    //MARK: - Methods
    func fetchJSONData() {
        guard let url = URL(string: "https://tiy-todo-angular.herokuapp.com/get-all-books.json") else {
            fatalError("failed to create URL")
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { (oData, oResponse, oError) in
        guard let data = oData,
            let httpResponse = oResponse as? HTTPURLResponse,
            let objects = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String:Any]]
            else {
                print("optionalResponse: \(oResponse)")
                print("optionalError: \(oError)")
                return
            }
            print("httpResponse.statusCode: \(httpResponse.statusCode)")
            
            print(objects)
        }
        task.resume()
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSONData()
    }
}

