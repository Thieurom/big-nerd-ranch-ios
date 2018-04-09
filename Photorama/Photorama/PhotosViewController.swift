//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Doan Le Thieu on 4/8/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var store: PhotoStore!
    var photoType: PhotoType = .interesting {
        didSet {
            fetchPhotos(ofType: photoType)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchPhotos(ofType: photoType)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            photoType = .interesting
        case 1:
            photoType = .recent
        default:
            break
        }
    }
    
    func fetchPhotos(ofType type: PhotoType) {
        imageView.image = nil
        spinner.startAnimating()

        store.fetchPhotos(ofType: type) { (photosResult) in
            self.spinner.stopAnimating()
            
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                
                if let firstPhoto = photos.first {
                    self.updateImageView(for: firstPhoto)
                }
            case let .failure(error):
                print("Error fetching photos: \(error)")
            }
        }
    }
    
    func updateImageView(for photo: Photo) {
        store.fetchImage(for: photo) { (imageResult) in
            switch imageResult {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error downloading image: \(error)")
            }
        }
    }
}
