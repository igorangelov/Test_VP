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
    
    var weatherModelView : WeatherViewModel?{
        didSet{
            guard let weatherMV = weatherModelView else { return }
            
            if let label = self.weatherLabel {
                label.text = weatherMV.dateTitle + "\n" + weatherMV.descriptionTitle
            }
            
            if let label = self.temperaturLabel {
                label.text = weatherMV.temperaturTitle
            }
            
            if let image = self.weatherImageView {
                image.downloadedFrom(link: weatherMV.imageUrl)
                
            }
    
        }
    }

}
