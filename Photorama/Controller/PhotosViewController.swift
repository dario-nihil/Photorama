//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Dario on 29/03/2020.
//  Copyright © 2020 Dario. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    //MARK: - Properties
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var segmentedCtrl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var photos = [Photo]()
    var store: PhotoStore!
    
    //MARK: - IBActions
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedCtrl.selectedSegmentIndex {
        case 0:
            store.fetchInterestingPhotos { (photoResult) in
                switch photoResult {
                case let .success(photos):
//                    if let firstPhoto = photos.first {
//                        self.updateImageView(for: firstPhoto)
//                    }
                    self.photos = photos
                case let .failure(error):
                    print("Error fetching interesting photos: \(error)")
                }
                
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
            print("Interestingness selected.")
        case 1:
            store.fetchRecentPhotos { (photoResult) in
                switch photoResult {
                case let .success(photos):
//                    if let firstPhoto = photos.first {
//                        self.updateImageView(for: firstPhoto)
//                    }
                    self.photos = photos
                case let .failure(error):
                    print("Error fetching recent photos: \(error)")
                }
                
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
            print("Recent selected.")
        default:
            print("Error while selecting a segment")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        store = PhotoStore()
        
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
//                if let firstPhoto = photos.first {
//                    self.updateImageView(for: firstPhoto)
//                }
                self.photos = photos
            case let .failure(error):
                print("Error fetching interesting photod: \(error)")
            }
            
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
//    func updateImageView(for photo: Photo) {
//        store.fetchImage(for: photo) { (imageResult) in
//            switch imageResult {
//            case let .success(image):
//                self.imageView.image = image
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }
    
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
}
