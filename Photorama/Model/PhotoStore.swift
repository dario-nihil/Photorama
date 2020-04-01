//
//  PhotoStore.swift
//  Photorama
//
//  Created by Dario on 29/03/2020.
//  Copyright © 2020 Dario. All rights reserved.
//

import UIKit

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class PhotoStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processPhotosRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    func fetchInterestingPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.interestingPhotosURL
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
//            if let jsonData = data {
//                if let jsonString =  String(data: jsonData, encoding: .utf8) {
//                    print(jsonString)
//                }
//                do {
//                    let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
//                    print(jsonObject)
//                } catch {
//                    print("Error creating JSON object: \(error)")
//                }
//            } else if let requestError = error {
//                print("Error fetching interesting photos: \(requestError)")
//            } else {
//                print("Unexpected error with the request")
//            }
            let httpResponse = (response as! HTTPURLResponse)
            print("Status Code: \(httpResponse.statusCode)\n")
            for (key,value) in httpResponse.allHeaderFields {
                print("\(key) : \(value)\n")
            }
            let result = self.processPhotosRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photos(fromJSON: jsonData)
    }
    
    func fetchImage(for photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoURL = photo.remoteUrl
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) { (data, response, error) in
            let result = self.processImageRequest(data: data, error: error)
            OperationQueue.main.addOperation {
                completion(result)
            }
        }
        task.resume()
    }
    private func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard
            let imageData = data,
            let image = UIImage(data: imageData) else {
            //Couldn't create an image
                if data == nil {
                    return .failure(error!)
                } else {
                    return .failure(PhotoError.imageCreationError)
                }
        }
        
        return .success(image)
    }
}
