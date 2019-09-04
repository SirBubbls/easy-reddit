//
//  AuthenticationManager.swift
//  reddit
//
//  Created by Lucas Sas on 08.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation
import Cocoa

public class AuthenticationManager {
    var clientId: String? = nil
    var token: OAuthToken?
    var state = "irasntuwfynta" // Needs to be randomly generated
    let redirect_uri = "redditapp://response"
//    let loginWindow: NSViewController
    
    
    static let shared = AuthenticationManager()
    
    init() {
//        let storyboard: NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
//        self.loginWindow = storyboard.instantiateController(withIdentifier: "login") as! NSViewController
        
        // Try to Load Token
        do{
            self.token = try self.loadToken()
            
            print("Token Loaded")
        }catch{
            print("Token Could not be Loaded")
        }
        
        refresh()
        
        
    }
    
    
    
    
    // TODO
    func checkToken() -> Bool {
        
        
        return false
    }
    
    
    
    func loadToken() throws -> OAuthToken? {
        print("Trying To Load Token")
        let defaults:UserDefaults = UserDefaults.standard
        
        let accessToken = defaults.string(forKey: "accessToken")
        let refreshToken = defaults.string(forKey: "refreshToken")
        
        if accessToken == nil && refreshToken == nil{
            return nil
        }
        
        return OAuthToken(accessToken: accessToken!, refreshToken: refreshToken!)
        
    }
    
    
    func requestNewToken() {
        let authUrl = "https://www.reddit.com/api/v1/authorize?client_id=\(self.clientId!)&response_type=code&state=\(self.state)&redirect_uri=\(self.redirect_uri)&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread"
        
        NSWorkspace.shared.open(URL(string: authUrl)!)
    }
    
    func viableToken() -> Bool {
        
        return false
    }
    
    func refresh() {
        let postData = "grant_type=refresh_token&refresh_token=\(token!.refreshToken)"
        let credentials = String(format: "%@:", self.clientId!)
        
        let request = PostRequest(url: URL(string: "https://www.reddit.com/api/v1/access_token")!, credentials: credentials, postData: postData)
        let json = request.makeRequest()
        
        let token: String = json["access_token"].stringValue
        
        if token > "" {
            self.token?.accessToken = token
            self.token?.save()
        }
        
    }
    
    func getTokenByCode(code: String) {
        let postData = "grant_type=authorization_code&code=\(code)&redirect_uri=\(self.redirect_uri)"
        let credentials = String(format: "%@:", self.clientId!)
        
        let request = PostRequest(url: URL(string: "https://www.reddit.com/api/v1/access_token")!, credentials: credentials, postData: postData)
        let json = request.makeRequest()
        self.token = OAuthToken(response: json)
        self.token?.save()
    }
    
    
    func interceptCode(url: URL) {
        print(url)
        let information = String(url.query!)
        
        let arguments = information.split(separator: "&")
        //
        let code = String(arguments[1].split(separator: "=")[1])
        self.state = String(arguments[0].split(separator: "=")[1])
        
        print("Code Intercepted: \(code)")
        
        self.getTokenByCode(code: String(code))
    }
}
