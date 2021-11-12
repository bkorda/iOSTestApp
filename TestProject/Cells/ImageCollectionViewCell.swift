//
//  ImageCollectionViewCell.swift
//  TestProject
//
//  Created by Bohdan Korda on 10.11.2021.
//

import UIKit
import Kingfisher
import SwiftUI

protocol ImageCollectionViewCellDelegate: AnyObject {
	func imageDownloaded()
}

class ImageCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet private weak var image: UIImageView!
	var delegate: ImageCollectionViewCellDelegate?
	
	var imageURL: URL! {
		didSet {
            image.kf.setImage(with: self.imageURL)
		}
	}
}
