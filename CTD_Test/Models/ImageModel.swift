//
//  ImageModel.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/24/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation

struct ImageModel: Decodable {
    let id: String
    let url: String
    let height: Float
    let width: Float
}
