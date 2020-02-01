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
    enum Endpoint{
        case randomDogImageFromTheCollection
        case ranomdImageForBreed(String)
        case allBreeds
        var url:URL{
            return URL(string: self.stringValue)!
        }
        var stringValue:String {
            switch self {
            case .randomDogImageFromTheCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .ranomdImageForBreed(let breed):
               return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .allBreeds:
                return "https://dog.ceo/api/breeds/list/all"
                
                
            }
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
    
    
    
    class func requestRandomImageForBreed(breed:String  ,  completionHandler: @escaping (DogImage? , Error?)->Void){
        let randomImageURL = DogApi.Endpoint.ranomdImageForBreed(breed).url
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
    
    class func getAllBreedsNames(completionHandler: @escaping([String] , Error?)->Void){
        
        let url:URL = DogApi.Endpoint.allBreeds.url
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                print ("Incorrect data")
                completionHandler([] , error)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                
                let breeds = try decoder.decode(BreedsResponse.self, from: data)
                           print (breeds)
                let allKeys = breeds.message.keys.map({$0})
                    print (allKeys)
                completionHandler(allKeys , nil )
            }catch{
                print (error)
            }
           
            
            
        }
        task.resume()
    }
}
