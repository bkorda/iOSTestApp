//
//  WebClient.swift
//  TestProject
//
//  Created by Bohdan Korda on 10.11.2021.
//

import Foundation

enum API {
	case users
	case photos(_ userId: Int)
	
	var path: String {
		switch self {
		case .users:
			return "users"
		case .photos:
			return "photos"
		}
	}
}

class WebClient {
	private let baseUrl = "https://jsonplaceholder.typicode.com"
	private let urlSession = URLSession.shared
	
	func fetchUsers(completion: @escaping ([User]?) -> Void) {
		guard let request = makeRequest(api: .users) else {
			completion(nil)
			return
		}
		
		urlSession.dataTask(with: request) { data, response, error in
			if let data = data {
				let users = try? JSONDecoder().decode([User].self, from: data)
				completion(users)
			}
		}.resume()
	}
	
	func fetchImages(for userId: Int,  completion: @escaping ([Image]?) -> Void) {
		guard let request = makeRequest(api: .photos(userId)) else {
			completion(nil)
			return
		}
		
		urlSession.dataTask(with: request) { data, response, error in
			if let data = data {
				let images = try? JSONDecoder().decode([Image].self, from: data)
				completion(images)
			}
		}.resume()
	}
	
	private func makeRequest(api: API) -> URLRequest? {
		guard let url = URL(string: baseUrl) else {
			return nil
		}
		switch api {
		case .users:
			let request = URLRequest(url: url.appendingPathComponent(api.path))
			return request
		case .photos(let userId):
			let finalUrl = url.appendingPathComponent("albums").appendingPathComponent(userId.description).appendingPathComponent(api.path)
			let request = URLRequest(url: finalUrl)
			return request
		}
	}
}
