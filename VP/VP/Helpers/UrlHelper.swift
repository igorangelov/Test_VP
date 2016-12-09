//
//  UrlHelper.swift
//  OodriveTest
//
//  Created by Igor Angelov on 30/11/2016.
//  Copyright © 2016 Igor Angelov. All rights reserved.
//

import UIKit

class UrlHelper {

    //http://api.openweathermap.org/data/2.5/forecast?q=paris,fr&mode=json&appid=a6587419bdbd54104a0e366c646fadb5
    // MARK: - GENERAL
    
    class func baseURL()->String
    {
        return "http://api.openweathermap.org/data/" + self.apiVersion()
    }
    
    class func apiVersion()->String
    {
        return "2.5"
    }
    
    class func apiToken () -> String
    {
        return "&appid=a6587419bdbd54104a0e366c646fadb5"
    }
   
    // MAKR: - meteo

    class func urlGetUserList()->String
    {
        return "\(self.baseURL())/forecast?q=paris,fr&mode=json" + self.apiVersion()
    }

   

    
}
