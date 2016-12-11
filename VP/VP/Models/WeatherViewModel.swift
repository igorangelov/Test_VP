//
//  WeatherViewModel.swift
//  VP
//
//  Created by Igor Angelov on 11/12/2016.
//  Copyright © 2016 Igor Angelov. All rights reserved.
//

import UIKit

class WeatherViewModel: NSObject {

    private let dictionary : [String:Any]
    
    var dateTitle : String = ""
    var descriptionTitle : String = ""
    var temperaturTitle : String = ""
    var imageUrl : String = ""
    
    init (dictionary: [String:Any]){
        self.dictionary = dictionary
        
        if let timestamp = self.dictionary["dt"] as? Double
        {
            let date = NSDate(timeIntervalSince1970: timestamp)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium
            dateFormatter.dateStyle = DateFormatter.Style.medium
            var localDate = dateFormatter.string(from: date as Date)
            localDate = localDate.replacingOccurrences(of: ":00 ", with: "  ")
            self.dateTitle = localDate
        }

    
        
        let array = self.dictionary["weather"] as? [Any]
        let dictW = array?[0] as? [String:Any]
        if let desc = dictW?["description"] as? String
        {
            self.descriptionTitle =  desc.capitalized
        }
    
        if let iconeName = dictW?["icon"] as? String {
            self.imageUrl  = "http://openweathermap.org/img/w/" + iconeName + ".png"
        }
        
        let mainDictionary  = self.dictionary["main"] as? [String:Any]
        if let temp = mainDictionary?["temp"] as? Double {
            let tempUnit = Locale.current.usesMetricSystem ? "°C" : "°F"
            self.temperaturTitle = String(temp) + tempUnit
        }
    }
}
