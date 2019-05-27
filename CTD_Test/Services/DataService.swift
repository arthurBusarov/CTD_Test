//
//  DataService.swift
//  CTD_Test
//
//  Created by Busarov, Arthur on 5/25/19.
//  Copyright © 2019 Busarov, Arthur. All rights reserved.
//

import Foundation

enum requestResult {
    case success
    case fail
    case error
}

class DataService {
    
    func doGetData(completition: @escaping (_ result: [ImageViewModel]?) -> Void ) {
        let dataUrlString = Credentials.shared.baseUrl + Credentials.shared.searchAppend
        NetworkService.shared.doGetRequest(withUrl: dataUrlString, completition: { (data, error) in
            guard let data = data else { return }
            do {
                let responseArray = try JSONDecoder().decode([ImageModel].self, from: data)
                let result = responseArray.map({return ImageViewModel(imageModel: $0)})
                completition (result)
            }
            catch {
                completition([])
            }
        })
    }
    
    func doRateImage(id: String,
                     rate: ImageViewModel.ActionsEnum,
                     completition: @escaping (_ result: requestResult) -> Void ) {
        let value = rate == .like ? 1 : 0
        let data = ["image_id": id, "value": value] as [String : Any]
        let rateUrlString = Credentials.shared.baseUrl + Credentials.shared.voteAppend
        NetworkService.shared.doPostRequest(withUrl: rateUrlString, data: data, completition: { (data, error) in
            guard let data = data else {
                completition(.fail)
                return
            }
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if response?["message"] as? String == "SUCCESS" {
                    completition(.success)
                } else {
                    completition(.fail)
                }
            } catch {
                completition(.error)
            }
        })
    }
}
