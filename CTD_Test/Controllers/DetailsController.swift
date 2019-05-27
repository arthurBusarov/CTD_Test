//
//  DetailsController.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/24/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation
import UIKit


class DetailsController: UIViewController {
    var viewModel: ImageViewModel?
    
    @IBOutlet weak var imageView: CacheableImageView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var width: NSLayoutConstraint!
    
    private var isUIUpdated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.loadFromString(urlString: viewModel?.imageUrl ?? "")
        
    }
    
    func setImageViewDimensions() {
        let newHeight = viewModel?.setDimensions(h: height)
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseIn, animations: {
            self.height.constant = newHeight ?? 0
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        if !isUIUpdated {
            isUIUpdated = true
            setImageViewDimensions()
        }
    }
    
    @IBAction func likeAction() {
        DataService().doRateImage(id: viewModel!.imageId,
                                  rate: .like,
                                  completition: { result in
                                    self.viewModel?.messageForAction(action: .like, result: result)
        })
        
    }
    
    @IBAction func dislikeAction() {
        DataService().doRateImage(id: viewModel!.imageId,
                                  rate: .dontLike,
                                  completition: { result in
                                    self.viewModel?.messageForAction(action: .dontLike, result: result)
        })
    }
    
    func showModelAlert() {
        guard let message = viewModel?.actionResultMessage else { return }
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.viewModel?.actionResultMessage = nil
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
