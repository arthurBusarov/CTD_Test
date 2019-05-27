//
//  ImageCell.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/25/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet private weak var cellImage: CacheableImageView!
    
    var imageUrl: String? {
        didSet {
            cellImage.loadFromString(urlString: imageUrl!)
        }
    }
    
    func didHighlighted() {
        UIView.animate(withDuration: 0.1) {
        self.cellImage.transform = .init(scaleX: 0.95, y: 0.95)
        self.contentView.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1)
        }
    }
    
    func didUnhighlighted() {
        UIView.animate(withDuration: 0.1) {
        self.cellImage.transform = .identity
        self.contentView.backgroundColor = .clear
        }
    }
}
