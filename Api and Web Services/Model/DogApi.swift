//
//  DogApi.swift
//  Api and Web Services
//
//  Created by Hassan on 27/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
import UIKit
class DogApi{
    enum Endpoint:String{
        case randomDogImageFromTheCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url:URL{
            return URL(string: self.rawValue)!
        }
    }
    
    class func requestImage(url:URL , completionHandler: @escaping (UIImage? , Error?)->Void){
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print("No data in the request")
                completionHandler(nil , error)
                return
            }
            if let image:UIImage = UIImage(data: data){
                completionHandler(image , nil)
            }
            
        }
        task.resume()
        
    }
   
    
    class func requestRandomImage1(completionHandler: @escaping (DogImage? , Error?)->Void){
        let randomImageURL = DogApi.Endpoint.randomDogImageFromTheCollection.url
           print (randomImageURL)
        let task = URLSession.shared.dataTask(with: randomImageURL) { (data, response, error) in
            guard let data = data else{
                            print("Can not get data from the url")
                             completionHandler(nil , error)
                            return
                        }
                        print ("The data is : \(data)")
                        
                        
                        let decoder = JSONDecoder()
                        let imageData = try! decoder.decode(DogImage.self, from: data)
                        print (imageData)
                     completionHandler(imageData , nil)
        }
        task.resume()
    }
}
