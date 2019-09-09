//
//  Media.swift
//  reddit
//
//  Created by Lucas Sas on 13.08.19.
//  Copyright © 2019 Lucas Sas. All rights reserved.
//

import Foundation
import Cocoa


public class Media {
    static func getPreview(url: URL) -> NSImage? {
        var request = URLRequest(url: url)
        
        let token = AuthenticationManager.shared.token!.accessToken
        
        // Request Header Information
        request.setValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("test_app by -IAmNotWhoIAm", forHTTPHeaderField: "User-Agent")
        request.httpMethod = "GET"
        
        let sem = DispatchSemaphore(value: 0)
        
        let session = URLSession.shared
        var image: NSImage?
        
        let task = session.dataTask(with: request) { data, response, error in
//            print(data, response, error)
            image = NSImage(data: data!) ?? nil
            sem.signal()
            
            
        }
        
        task.resume()
        sem.wait()
        
        return image
        
    
    }
}
