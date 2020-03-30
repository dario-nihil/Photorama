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
    @IBOutlet weak var imageView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store = PhotoStore()
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
            case let .failure(error):
                print("Error fetching interesting photod: \(error)")
            }
        }
    }
    
}
