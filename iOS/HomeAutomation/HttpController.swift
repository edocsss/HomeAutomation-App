//
//  HttpController.swift
//  HomeAutomation
//
//  Created by Edwin Candinegara on 28/1/17.
//  Copyright © 2017 Edwin Candinegara. All rights reserved.
//

import Foundation
import Alamofire


class HttpController {
    private static var instance: HttpController? = nil;
    
    static func getInstance() -> HttpController? {
        if instance == nil {
            instance = HttpController()
        }
        
        return instance
    }
    
    func httpRequestWithoutAuth(url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding?) -> DataRequest {
        return Alamofire.request(
            url,
            method: method, 
            parameters: parameters,
            encoding: encoding == nil ? URLEncoding.default : encoding!
        )
    }
    
    func httpRequestWithAuth(url: String, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding?) -> DataRequest {
        let basicAuth = AuthController.getInstance()?.getBasicAuthorization() // Although the return type is String, it's actually a String? --> probably because of the getInstance?
        let headers: HTTPHeaders = [
            "Authorization": "Basic \(basicAuth!)"
        ]
        
        return Alamofire.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding == nil ? URLEncoding.default : encoding!,
            headers: headers
        )
    }
}
