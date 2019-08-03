//
//  APIManager.swift
//  DemoApp
//
//  Created by Anshul on 8/3/19.
//  Copyright © 2019 Anshul. All rights reserved.
//

import UIKit
import AFNetworking

class APIManager: NSObject {

    private let sessionManager = AFHTTPSessionManager()
    
    static let sharedInstance = APIManager()
    
    
    func hitLoginAPI(params: NSDictionary, url : String, completion: @escaping (_ success : Bool, _ response : AnyObject?) -> Void) {
        
        sessionManager.requestSerializer = AFJSONRequestSerializer()
        sessionManager.responseSerializer = AFJSONResponseSerializer()
        sessionManager.requestSerializer.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        sessionManager.responseSerializer.acceptableContentTypes = NSSet(objects: "text/html","application/json","text/json","text/plain","application/x-www-form-urlencoded") as? Set<String>
        
        sessionManager.post(url, parameters: params, progress: nil, success: { (task, response) in
            
            completion(true, response as AnyObject)
            
        }) { (task, error) in
            completion(false, error as AnyObject)
        }
        
        
    }
    
    
}
