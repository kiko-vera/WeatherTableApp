//
//  WeatherForecastTableViewCell.swift
//  WeatherTableApp
//
//  Created by Christopher Vera on 1/19/19.
//  Copyright © 2019 FSCApps. All rights reserved.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayOfTheWeekLabel: UILabel!
    @IBOutlet weak var weatherForecastIcon: UIImageView!
    @IBOutlet weak var lowTemperatureForecastLabel: UILabel!
    @IBOutlet weak var highTemperatureForecastLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
