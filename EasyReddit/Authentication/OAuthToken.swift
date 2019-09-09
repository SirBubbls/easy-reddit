//
//  OAuthToken.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


public class OAuthToken {
    
    /**
     Variables
    */
    
    let scope: String?
    let expiresIn: Int?
    let tokenType: String?

    public var accessToken: String
    public let refreshToken: String

    
    
    /**
     Extract Token from a reponse.
     - parameter reponse: Response data as Json
    */
    
    public init(response: JSON) {
        self.scope = response["scope"].string
        self.refreshToken = response["refresh_token"].string!
        self.accessToken = response["access_token"].string!
        self.expiresIn = response["expires_in"].int
        self.tokenType = response["token_type"].string
    }
    
    
    
    /**
     Initialize OAuth Token object manually.
     - parameter accessToken: access token is used to make requests.
     - parameter refreshToken: refresh token used to request a new access token.
    */
    
    public init(accessToken: String, refreshToken: String) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        
        // Not necessary values will be initailized as nil
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
    
    
    
    /**
     Saving Token in UserDefaults.
    */
    
    func save(){
        let defaults:UserDefaults = UserDefaults.standard
        
        defaults.set(self.accessToken, forKey: "accessToken")
        defaults.set(self.refreshToken, forKey: "refreshToken")
    }
    
    
}
