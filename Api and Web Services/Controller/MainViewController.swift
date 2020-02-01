//
//  MainViewController.swift
//  Api and Web Services
//
//  Created by user on 27/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var dogImage: UIImageView!
    
    var breeds:[String] = ["greyhound" ,  "poodle"  ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        DogApi.getAllBreedsNames(completionHandler: handleBreedsRespons(breeds:error:))
       // DogApi.requestRandomImage1(completionHandler: handleRandomImageFromURL(imageData:error:))
        
        
       
    }
    
    func handleBreedsRespons(breeds:[String], error:Error?)->Void{
        self.breeds = breeds
                  DispatchQueue.main.async {
                      self.pickerView.reloadAllComponents()
                  }
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

extension MainViewController:UIPickerViewDelegate , UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogApi.requestRandomImageForBreed(breed: breeds[row], completionHandler: handleRandomImageFromURL(imageData:error:))
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
}
