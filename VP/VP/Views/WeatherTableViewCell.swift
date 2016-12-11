//
//  WeatherTableViewCell.swift
//  VP
//
//  Created by Igor Angelov on 10/12/2016.
//  Copyright © 2016 Igor Angelov. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherLabel : UILabel!
    @IBOutlet weak var temperaturLabel : UILabel!
    @IBOutlet weak var weatherImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var dictWeather : [String: Any]?{
        didSet{
            guard let dict = dictWeather else { return }
            
            let date = NSDate(timeIntervalSince1970: (dict["dt"] as? Double)!)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium
            dateFormatter.dateStyle = DateFormatter.Style.medium
            var localDate = dateFormatter.string(from: date as Date)
            localDate = localDate.replacingOccurrences(of: ":00 ", with: "  ")
            
            let array = dict["weather"] as? [Any]
            let dictW = array?[0] as? [String:Any]
            if let iconeName = dictW?["icon"] as? String {
                let urlImage  = "http://openweathermap.org/img/w/" + iconeName + ".png"
                self.weatherImageView.downloadedFrom(link: urlImage)
            }
            
            if let desc = dictW?["description"] as? String
            {
                    self.weatherLabel.text = localDate + "\n" + desc.capitalized
            }
            
            let mainDictionary  = dict["main"] as? [String:Any]
            if let temp = mainDictionary?["temp"] as? Double {
                let tempUnit = Locale.current.usesMetricSystem ? "°C" : "°F"
                self.temperaturLabel.text = String(temp) + tempUnit
            }
            
        }
    }

}
