//
//  DetailViewController.swift
//  VP
//
//  Created by Igor Angelov on 09/12/2016.
//  Copyright © 2016 Igor Angelov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var detailTemperaturLabel : UILabel!
    @IBOutlet weak var detailImageView: UIImageView!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                
                let date = NSDate(timeIntervalSince1970: (detail["dt"] as? Double)!)
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.medium
                dateFormatter.dateStyle = DateFormatter.Style.medium
                var localDate = dateFormatter.string(from: date as Date)
                localDate = localDate.replacingOccurrences(of: ":00 ", with: "  ")
                
                let array = detail["weather"] as? [Any]
                let dictW = array?[0] as? [String:Any]
               
                
                if let desc = dictW?["description"] as? String
                {
                    label.text = localDate + "\n" + desc.capitalized
                }
                
                if let image = self.detailImageView {
                    if let iconeName = dictW?["icon"] as? String {
                        let urlImage  = "http://openweathermap.org/img/w/" + iconeName + ".png"
                        image.downloadedFrom(link: urlImage)
                    }
                }
                
                let mainDictionary  = detail["main"] as? [String:Any]
                if let temp = mainDictionary?["temp"] as? Double {
                    let tempUnit = Locale.current.usesMetricSystem ? "°C" : "°F"
                    self.detailTemperaturLabel.text = String(temp) + tempUnit
                }

            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: [String:Any]? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

