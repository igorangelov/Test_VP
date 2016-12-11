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
                label.text = detail.dateTitle + "\n" + detail.descriptionTitle
            }
            
            if let label = self.detailTemperaturLabel {
                label.text = detail.temperaturTitle
            }
            
            if let image = self.detailImageView {
                image.downloadedFrom(link: detail.imageUrl)
                
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

    var detailItem: WeatherViewModel? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }


}

