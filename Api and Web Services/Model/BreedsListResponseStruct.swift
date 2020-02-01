//
//  BreedsListResponseStruct.swift
//  Api and Web Services
//
//  Created by user on 01/02/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
struct BreedsResponse:Codable{
    let status:String
    let message:[String:[String]]
}
