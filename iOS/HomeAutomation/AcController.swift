//
//  AcController.swift
//  HomeAutomation
//
//  Created by Edwin Candinegara on 26/1/17.
//  Copyright © 2017 Edwin Candinegara. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class AcController {
    private static var instance: AcController? = nil;
    
    static func getInstance() -> AcController? {
        if instance == nil {
            instance = AcController()
        }
        
        return instance
    }
    
    func getCurrentAcState(callback: @escaping (_ success: Bool, _ acState: Bool) -> Void) {
        HttpController.getInstance()?.httpRequestWithoutAuth(url: URL.STATUS_URL, method: .get, parameters: nil, encoding: nil).responseJSON { response in
            switch response.result {
            case .success:
                let jsonData = JSON(response.result.value!)
                callback(true, jsonData["acState"].boolValue)
            
            case .failure(let error):
                print("ERROR DURING GETTING CURRENT AC STATE!")
                print(error)
                callback(false, false)
            }
        }
    }
    
    func changeAcState(acState: Bool, callback: @escaping (_ success: Bool, _ acState: Bool) -> Void) {
        let jsonBody: Parameters = [
            "acState": acState
        ]
        
        HttpController.getInstance()?.httpRequestWithAuth(url: URL.AC_URL, method: .post, parameters: jsonBody, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                callback(true, acState)
                
            case .failure(let error):
                print("ERROR DURING CHANGING AC STATE!")
                print("Next AC State: \(acState)")
                print(error)
                callback(false, false)
            }
        }
    }
}
