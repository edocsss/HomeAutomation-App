//
//  AuthController.swift
//  HomeAutomation
//
//  Created by Edwin Candinegara on 28/1/17.
//  Copyright © 2017 Edwin Candinegara. All rights reserved.
//

import Foundation


class AuthController {
    private static var instance: AuthController? = nil

    static func getInstance() -> AuthController? {
        if instance == nil {
            instance = AuthController()
        }
        
        return instance
    }
    
    func getBasicAuthorization() -> String {
        let basicAuth = "\(AuthConfig.USERNAME):\(AuthConfig.PASSWORD)"
        return Data(basicAuth.utf8).base64EncodedString()
    }
}
