//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Doan Le Thieu on 4/9/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var totalViewsLabel: UILabel!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) { (result) in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        
        photo.totalViews += 1
        totalViewsLabel.text = "\(photo.totalViews) view(s)"
        store.saveIfNeeded()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTags"?:
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            tagController.store = store
            tagController.photo = photo
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
}
