//
//  UsersViewController.swift
//  TestProject
//
//  Created by Bohdan Korda on 10.11.2021.
//

import UIKit

let cellIdentifier: String = "usercell"

class UsersViewController: UITableViewController {
	
    private let webClient: WebClient
    private var users: [User]?
    
    required init?(coder aDecoder: NSCoder) {
        self.webClient = WebClient()
        self.users = []
        super.init(coder: aDecoder)
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		webClient.fetchUsers { users in
			self.users = users
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return users?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
			fatalError()
		}
		
		var configuration = cell.defaultContentConfiguration()
		
		configuration.text = users?[indexPath.row].username
		configuration.secondaryText = users?[indexPath.row].name
		
		cell.contentConfiguration = configuration
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		guard let viewController = self.storyboard?.detailViewController() else {
			fatalError()
		}
		viewController.userId = users?[indexPath.row].id
		self.show(viewController, sender: nil)
	}

}

