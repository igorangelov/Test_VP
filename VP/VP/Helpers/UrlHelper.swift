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
        return "http://api.openweathermap.org/data/" + UrlHelper.apiVersion()
    }
    
    class func apiVersion()->String
    {
        return "2.5"
    }
   
    // MAKR: - USER

    class func urlGetUserList()->String
    {
        return "\(UrlHelper.getBaseURL())/users"
    }

    class func urlGetUserAlbums(id:Int)->String
    {
        return "\(UrlHelper.getBaseURL())/users/\(id)/albums"
    }
    
    class func urlGetAlbumPhotos(id:Int)->String
    {
        return "\(UrlHelper.getBaseURL())/albums/\(id)/photos"
    }

    
}
