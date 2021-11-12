//
//  DetailCollectionViewController.swift
//  TestProject
//
//  Created by Bohdan Korda on 10.11.2021.
//

import UIKit

private let reuseIdentifier = "imageCell"

class DetailCollectionViewController: UICollectionViewController {

    var userId: Int?
    var images: [Image]?
    let webClient: WebClient
    
    required init?(coder aDecoder: NSCoder) {
        self.webClient = WebClient()
        self.images = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
		guard let userId = userId else {
			fatalError()
		}

        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
		webClient.fetchImages(for: userId) { images in
			self.images = images
			DispatchQueue.main.sync {
				self.collectionView.reloadData()
			}
		}
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
			fatalError()
		}
		
		guard let imageUrlString = images?[indexPath.row].url,
			let url = URL(string: imageUrlString) else {
			fatalError()
		}
    
		cell.imageURL = url
		cell.delegate = self
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension DetailCollectionViewController: ImageCollectionViewCellDelegate {
	func imageDownloaded() {
		print("image ready")
	}
}
