//
//  CatFlowRouter.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/24/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

protocol Router {
    func go(
        to routeID: String,
        from context: UIViewController,
        parameters: Any?
    )
}

import Foundation
import UIKit

class CatFlowRouter: Router {
    func go(to routeID: String, from context: UIViewController, parameters: Any?) {
        guard let route = HomeController.Route(rawValue: routeID) else {
            return
        }
        switch route {
        case .details:
            //go to details
            let vc = Credentials.shared.storyboard.instantiateViewController(withIdentifier:"DetailsController") as! DetailsController
            vc.viewModel = parameters as? ImageViewModel
            //TODO add some params
            context.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
