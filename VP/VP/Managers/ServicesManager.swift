//
//  ServicesManager.swift
//  OodriveTest
//
//  Created by Igor Angelov on 20/11/2016.
//  Copyright © 2016 Igor Angelov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias ResultResponseManager = (_ errorResponse: ErrorResponseType, _ jsonResponse: Any?) -> Void

enum ErrorResponseType {
    case Unknown
    case None // No Error
    case Error // All Error
}

enum HeaderContentType : String {
    case Basic = "application/json"
    case Download = "application/octet-stream"
    case Upload = "upload" // don't use in header dictionary
}


class ServicesManager {

    
    //*****************
    // Basic get RESTAPI
    //**************
    
    class func get(url : String, cached isCached : Bool = true, callback: @escaping ResultResponseManager)
    {
        
        debugPrint(url)

        //manager cached data func
        func getCachedData()
        {
            
            SupraCacheManager.getData(url: url, expiredAt: SupraCacheManager.makeExpiredDayWeek(weekLater: 1), completion: { (errors, data) -> Void in
                
                if errors == nil {
                    
                    // if can find cached
                    if let swiftyJsonVar : [String:Any] = JSON(data: data as! Data).dictionaryObject {
                        callback(.None, swiftyJsonVar )
                        return
                    }
                    // if cannot find cached
                    callback(.Error, nil )
                    return
                }
                
            }, callResource: nil)
        }
        
        if(Reachability.isConnectedToNetwork() == false){
            getCachedData()
            return
        }
        
        Alamofire.request(url,
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ServicesManager.requestHeader(type:.Basic )
            ).response { (response) in
                
              
                
                guard let code = response.response?.statusCode else
                {
                    getCachedData()
                    callback(.Error, nil )
                    return
                }
                
                
                ///* Request fine */
                if(ServicesManager.canSendResponse(code: code))
                {
                    //Verifiy Data
                    if let data = response.data{
                        let swiftyJsonVar : [String:Any] = JSON(data: data).dictionaryObject!
                        callback(.None, swiftyJsonVar )
                        //cache Data
                        SupraCacheManager.pushDataToCache(url: url, expiredAt: SupraCacheManager.makeExpiredDayWeek(weekLater: 1), data: data as NSData)
                    }
                }else{ ///* Request not fine */

                    getCachedData()
                    callback(.Error, nil )
                }
                
        }
        

    }
    
    //***************************
    //get weather for 5 days for API
    //***************************
    class func getWeather(callback: @escaping ResultResponseManager) {
        
        ServicesManager.get(url: UrlHelper.urlGetWeather(), callback: callback)
    }
    
    
    
    //***************************
    //retour bool depend of http code
    //***************************
    class func canSendResponse(code : Int) -> Bool {
        
        switch code {
        case 200...201 : /* Request fine */
            return true
        case 400...550 : /*errors*/
            return false
        default: /* Error no defined yet */
            return false
        }
        
    
    }
    //***************************
    //return header for request for type
    //***************************
    class func requestHeader(type:HeaderContentType, fileName:String = "")->[String:String]
    {
        let plainString = "noel:foobar" as String
        let plainData = plainString.data(using: .utf8)
        let base64String = plainData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        
        var headers = [
            "Authorization":  "Basic " + base64String!,
            "Content-Type": type.rawValue
        ]
        
        if(type == .Upload)
        {
             headers = [
                "Authorization":  "Basic " + base64String!,
                "Content-Type": HeaderContentType.Download.rawValue,
                "Content-Disposition": "attachment;filename*=utf-8''"+fileName
            ]
        }
        
        return headers
        
    }
    
}

