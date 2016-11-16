//
//  GoogleDocsClient.swift
//  Saba Center
//
//  Created by Ali Mir on 11/6/16.
//  Copyright © 2016 com.AliMir. All rights reserved.
//

import UIKit

class GoogleDocsClient: NSObject {
    
    // MARK: Properties
    
    // shared session
    var session = URLSession.shared
    
    // MARK: Initializers
    
    override init() {
        super.init()
    }
    
    // MARK: GET
    
    func taskForGETMethod(sectionCode: String, completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {

        /* Build the URL, Configure the request */
        let request = URLRequest(url: GoogleDocsURL(withSectionCode: sectionCode))
        
        print("Request URL: \(request)")
        
        /* Make the request */
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "Request error!")
                return
            }
            
            guard let responseStatusCode = (response as? HTTPURLResponse)?.statusCode, 200...299 ~= responseStatusCode else {
                sendError(error: "Not a successful response range 2xx!")
                return
            }
            
            guard let data = data else {
                sendError(error: "No data returned!")
                return
            }
            
            /* Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data: data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        // Start the request
        task.resume()
        
        return task
    }
    
    // MARK: Helpers
    
    // create a URL from parameters and path extensions
    private func GoogleDocsURL(withSectionCode sectionCode: String) -> URL {
        var components = URLComponents()
        components.scheme = GoogleDocsClient.Costants.Scheme
        components.host = GoogleDocsClient.Costants.Host
        components.path = substituteKeyInMethod(method: GoogleDocsClient.Costants.Path, key: GoogleDocsClient.SectionCodes.SectionCode, value: sectionCode)!
        components.queryItems = [URLQueryItem]()
        let queryItem = URLQueryItem(name: "alt", value: "json") // json format
        components.queryItems?.append(queryItem)
        
        return components.url!
    }
    
    // substitute the key for the value that is contained within the method name
    func substituteKeyInMethod(method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
    // given raw JSON, return a usable Foundation object
    func convertDataWithCompletionHandler(data: Data, completionHandlerForConvertData: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            print("Error in converting data object to JSON: \(error)")
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
            return
        }
        
        DispatchQueue.global(qos: DispatchQoS.background.qosClass).async {
            performUIUpdatesOnMain {
                completionHandlerForConvertData(parsedResult, nil)
            }
        }
        
    }
    
    // MARK: Shared Instance
    
    class func shared() -> GoogleDocsClient {
        struct Singleton {
            static var shared = GoogleDocsClient()
        }
        return Singleton.shared
    }
}
