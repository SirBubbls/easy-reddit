//
//  AuthenticationManager.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation


public class AuthenticationManager {
    
    /**
     Variables
    */
    
    public var clientId: String? = nil
    var token: OAuthToken?
    
    // TODO: Needs to be randomly generated
    var state = "irasntuwfynta"
    let redirect_uri = "redditapp://response"
    
    
    public static let shared = AuthenticationManager()
    
    public init() {

        // Try to Load Token
        do{
            self.token = try self.loadToken()
            NSLog("Token Loaded")
            self.token?.getInfo()
        }catch{
            
            NSLog("Token Could not be Loaded")
        }
    }
    
    
    
    
    // TODO
    public func checkToken() -> Bool {
        let call = ApiCall(method: "/api/v1/me", requestType: "GET")
        
        call.requiresAuth = true
        
        do {
            let _ = try call.execute()
            return true
        } catch {
            
            print("CheckToken: False")
            return false
        }
        
    }
    
    
    
    /**
     Tries to load Token stored in UserDefaults.
     Throws exception if no entry could be found.
    */
    
    private func loadToken() throws -> OAuthToken? {
        
        let defaults:UserDefaults = UserDefaults.standard
        
        let accessToken = defaults.string(forKey: "accessToken")
        let refreshToken = defaults.string(forKey: "refreshToken")
        
        if refreshToken == nil{
            return nil
        }
        
        return OAuthToken(accessToken: accessToken!, refreshToken: refreshToken!)
        
    }
    
    
    /**
     Opens a URL with a grant access dialogue.
    */
    
    public func requestNewToken() {
        let authUrl = "https://www.reddit.com/api/v1/authorize?client_id=\(self.clientId!)&response_type=code&state=\(self.state)&redirect_uri=\(self.redirect_uri)&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread"
        
        NSWorkspace.shared.open(URL(string: authUrl)!)
    }
    
    
    /**
     Requests a new access token by providing the revresh token found in OAuthToken.
    */
    
    public func refresh() {
        let postData = "grant_type=refresh_token&refresh_token=\(token!.refreshToken)"
        let credentials = String(format: "%@:", self.clientId!)
        
        let request = PostRequest(url: URL(string: "https://www.reddit.com/api/v1/access_token")!, credentials: credentials, postData: postData)
        let json = request.makeRequest()
        
        let token: String = json!["access_token"].stringValue
        
        NSLog("New token: \(token)")
        
        if token > "" {
            self.token?.accessToken = token
            self.token?.save()
        }
        
    }
    
    
    /**
     After a code has been intercepted by interceptCode(url: URL).
     - parameter code: return code that got intercepted
    */
    
    private func getTokenByCode(code: String) {
        let postData = "grant_type=authorization_code&code=\(code)&redirect_uri=\(self.redirect_uri)"
        let credentials = String(format: "%@:", self.clientId!)
        
        let request = PostRequest(url: URL(string: "https://www.reddit.com/api/v1/access_token")!, credentials: credentials, postData: postData)
        let json = request.makeRequest()
        self.token = OAuthToken(response: json!)
        self.token?.save()
    }
    
    
    
    /**
     Use this function to process a
     - parameter url: return url
    */
    
    public func interceptCode(url: URL) {
        
        let information = String(url.query!)
        
        let arguments = information.split(separator: "&")
        
        // Extracting code from url
        let code = String(arguments[1].split(separator: "=")[1])
        
        // Extracting state variable from url
        self.state = String(arguments[0].split(separator: "=")[1])
        
        // Generating Token and returning
        self.getTokenByCode(code: String(code))
    }
}
