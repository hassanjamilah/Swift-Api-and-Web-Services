//
//  MainViewController.swift
//  Api and Web Services
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var dogImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DogApi.requestRandomImage1(completionHandler: handleRandomImageFromURL(imageData:error:))
           
        
       
    }
    
    func handleRandomImageFromURL(imageData : DogImage? , error : Error?)->Void{
        guard let imageData = imageData else {
            print ("Failed to get data")
            return
        }
        let url:URL = URL(string: imageData.message)!
        DogApi.requestImage(url: url, completionHandler: handleTheImageFromResponse(_:_:))
    }
    
    func handleTheImageFromResponse(_ image:UIImage? , _ error:Error?)->Void{
        DispatchQueue.main.async {
            
            self.dogImage.image = image
        }
    }
    
    
}
