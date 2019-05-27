//
//  ImageViewModel.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/24/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation
import UIKit

class ImageViewModel {
    
    enum ActionsEnum {
        case like
        case dontLike
    }
    
    var imageUrl: String!
    var imageId: String!
    private var imageWidth: CGFloat
    private var imageHeight: CGFloat
    var height: CGFloat?
    var actionResultMessage: String?
    
    init(imageModel: ImageModel) {
        imageUrl = imageModel.url
        imageId = imageModel.id
        imageWidth = CGFloat(imageModel.width)
        imageHeight = CGFloat(imageModel.height)
    }
    
    //Made for smooth animation
    func setDimensions (h: NSLayoutConstraint) -> CGFloat {
        let imageRatio = imageHeight / imageWidth
        let result = imageRatio * h.constant
        return result > UIScreen.main.bounds.height - 150 ? UIScreen.main.bounds.height - 150 : result
    }
    
    //Some message for defining current viewModelStatus
    func messageForAction(action: ActionsEnum, result: requestResult) {
        var resultMessage = ""
        var actionMessage = ""
        switch result {
        case .success:
            resultMessage = "You successfully "
        case .error, .fail:
            resultMessage = "Oops there is an error. You haven't "
        }
        
        switch action {
        case .like:
            actionMessage = "LIKED it! 👍"
        default:
            actionMessage = "DISLIKED it! 😡"
        }
        actionResultMessage = resultMessage + actionMessage
    }
}
