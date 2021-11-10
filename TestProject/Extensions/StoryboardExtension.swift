//
//  StoryboardExtension.swift
//  TestProject
//
//  Created by Bohdan Korda on 10.11.2021.
//

import Foundation
import UIKit

extension UIStoryboard {
	func detailViewController() -> DetailCollectionViewController? {
		return self.instantiateViewController(withIdentifier: "DetailCollectionViewController") as? DetailCollectionViewController
	}
}
