//
//  OAuthToken.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation

public class OAuthToken {
    let scope: String?
    let refreshToken: String
    let expiresIn: Int?
    var accessToken: String
    let tokenType: String?
    
    
    init(response: JSON) {
        self.scope = response["scope"].string
        self.refreshToken = response["refresh_token"].string!
        self.accessToken = response["access_token"].string!
        self.expiresIn = response["expires_in"].int
        self.tokenType = response["token_type"].string
        
        self.getInfo()
    }
    
    init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        
        self.scope = nil
        self.expiresIn = nil
        self.tokenType = nil
    }
    
    public func getInfo() {
        print("Scope: \(self.scope ?? "unknown")")
        print("Refresh Token: \(self.refreshToken)")
        print("Access Token: \(self.accessToken)")
        print("Expires In: \(self.expiresIn ?? -1)")
        print("Token Type: \(self.tokenType ?? "unknown")")
    }
    
    
    func save(){
        print("Saving OAuth Token in UserDefaults.standard")
        let defaults:UserDefaults = UserDefaults.standard
        
        defaults.set(self.accessToken, forKey: "accessToken")
        defaults.set(self.refreshToken, forKey: "refreshToken")
    }
    
    
}
