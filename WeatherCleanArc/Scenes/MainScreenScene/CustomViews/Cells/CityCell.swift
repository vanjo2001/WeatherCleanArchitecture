//
//  CityCell.swift
//  WeatherCleanArc
//
//  Created by IvanLyuhtikov on 18.10.20.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var code: UILabel!
    
    var data: MainScreen.DefaultListOfCities.CityInfo! {
        didSet {
            city.text = data.city
            code.text = data.code
        }
    }
    
    static let reusableIdentifier = "CityCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
