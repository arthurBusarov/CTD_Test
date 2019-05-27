//
//  Credentials.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/25/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation
import UIKit

class Credentials {
    static let shared = Credentials()
    private init(){}
    
    let baseUrl = "https://api.thecatapi.com/v1"
    let searchAppend = "/images/search?limit=40&page=100&order=DESC"
    let voteAppend = "/votes"
    let apiKey = "ad8e96ee-1b8b-4f14-b6e6-1541007ea331"
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
}
