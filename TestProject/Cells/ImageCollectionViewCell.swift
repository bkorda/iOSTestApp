//
//  ImageCollectionViewCell.swift
//  TestProject
//
//  Created by Bohdan Korda on 10.11.2021.
//

import UIKit

protocol ImageCollectionViewCellDelegate: AnyObject {
	func imageDownloaded()
}

class ImageCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet private weak var image: UIImageView!
	var delegate: ImageCollectionViewCellDelegate?
	
	var imageURL: URL! {
		didSet {
			downloadImage()
		}
	}
	
	private func downloadImage() {
		if let data = try? Data(contentsOf: self.imageURL) {
			if let image = UIImage(data: data) {
				self.image.image = image
				self.delegate?.imageDownloaded()
			}
		}
	}
}
