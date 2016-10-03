//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Minni K Ang on 2016-09-28.
//  Copyright © 2016 CreativeIce. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var hiTempLbl: UILabel!
    @IBOutlet weak var loTempLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(forecast: WeatherForecast) {
        
        weatherLabel.text = forecast.weatherType
        hiTempLbl.text = "\(forecast.tempMax)" + "º"
        loTempLbl.text = "\(forecast.tempMin)" + "º"
        dayLabel.text = forecast.date
        weatherImg.image = UIImage(named: forecast.weatherType)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
