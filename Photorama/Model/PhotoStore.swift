//
//  PhotoStore.swift
//  Photorama
//
//  Created by Dario on 29/03/2020.
//  Copyright © 2020 Dario. All rights reserved.
//

import Foundation

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

class PhotoStore {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
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
            let result = self.processPhotosRequest(data: data, error: error)
            completion(result)
        }
        task.resume()
    }
    
    private func processPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photos(fromJSON: jsonData)
    }
}
