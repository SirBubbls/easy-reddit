//
//  ApiCall.swift
//  EasyReddit
//
//  Created by Lucas Sas on 04.09.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation
//import SwiftyJSON


// Internface for POST & GET API Requests
public class ApiCall {
    let url: URL
    let requestType: String
    var headerParameters: [String: String]?
    var parameters: [String: String]?
    var bodyParameters: [String: String]?
    var requiresAuth: Bool = false
    
    
    init(method: String, requestType: String) {
        self.url = URL(string: "https://oauth.reddit.com" + method)!
        self.requestType = requestType
        self.headerParameters = nil
        self.parameters = nil
        self.bodyParameters = nil
    }
    
    public func addHeaderParameters(parameters: [String: String]) {
        self.parameters = parameters
    }
    
    public func addParameters(parameters: [String: String]){
        self.parameters = parameters
    }
    
    func execute() throws -> JSON {
        switch self.requestType {
        case "POST":
            return self.postRequest()
        case "GET":
            return self.getRequest()
        default:
            print("Not a Valid Request")
        }
        
        return JSON()
    }
    
    // Execute GET Request
    // gets called by public function .execute()
    private func getRequest() -> JSON {
        
        // Process URL Parameters
        var urlParameters = "?"
        for key in (self.parameters ?? [String: String]()).keys {
            urlParameters.append("\(key)=\(self.parameters![key]!)&")
        }
        
        // Construct Final URL with added Parameters
        // https://oauth.reddit.com/<method>?<parameters>
        let finalURL: String = "\(self.url.absoluteURL)\(urlParameters)"
        
        // Initializing GET Request
        var request = URLRequest(url: URL(string: finalURL)!)
        request.httpMethod = "GET"
        
        // Getting accessToken from Authentication Manager
        let token = AuthenticationManager.shared.token!.accessToken
        
        // Request Header Information
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("test_app by -IAmNotWhoIAm", forHTTPHeaderField: "User-Agent")
        
        // Adding Header Parameters
        for key in (self.headerParameters ?? [String: String]()).keys {
            request.setValue(self.headerParameters![key]!, forHTTPHeaderField: key)
        }
        
        // Executing and returning
        return Request(request: request).makeRequest()
    }
    
    // TODO: Not working currently (i think)
    private func postRequest() -> JSON{
        var urlParameters = "?"
        
        for key in (self.parameters ?? [String: String]()).keys {
            urlParameters.append("\(key)=\(self.parameters![key]!)&")
        }
        
        // Final URL with added URL Parameters
        let finalURL: String = "\(self.url.absoluteURL)\(urlParameters)"
        
        var request = URLRequest(url: URL(string: finalURL)!)
        
        
        if requiresAuth {
            let token = AuthenticationManager.shared.token!.accessToken
            request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        request.setValue("test_app by -IAmNotWhoIAm", forHTTPHeaderField: "User-Agent")
        
        request.httpMethod = "POST"
        
        
        return Request(request: request).makeRequest()
        
    }
}
