//
//  ViewController.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/24/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    enum Route: String {
        case details
    }
    var viewModel: ImageViewModel!
    var router: Router!

    @IBOutlet var collection: UICollectionView!

    var dataArray: [ImageViewModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        router = CatFlowRouter()
        
        DataService().doGetData(completition: { result in
            self.dataArray = result
            DispatchQueue.main.async {
                self.collection.reloadData()
            }
        })
    }
}

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCellIdentifier", for: indexPath) as! ImageCell
        let viewModel = dataArray?[indexPath.row]
        cell.imageUrl = viewModel?.imageUrl
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collection.frame.width / 2) - 5, height: collection.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = dataArray?[indexPath.row]
        router.go(to: Route.details.rawValue, from: self, parameters: model)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
            cell.didHighlighted()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ImageCell {
            cell.didUnhighlighted()
        }
    }
}
