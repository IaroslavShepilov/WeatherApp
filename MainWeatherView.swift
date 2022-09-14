//
//  MainWeatherView.swift
//  NatifeTestProj
//
//  Created by Dmitriy Ponomarenko on 23.08.2022.
//

import UIKit

class MainWeatherView: UIView {
    
    @IBOutlet var mainWeatherview: UIView!
    @IBOutlet weak var chooseLocationButton: UIButton!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    var view: UIView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        let viewFromXib = Bundle.main.loadNibNamed("MainWeatherView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = CGRect(x: 0, y: 0, width: mainWeatherview.bounds.width, height: self.bounds.height) // ??? 
        addSubview(viewFromXib)
        self.backgroundColor = .clear
    }
    
    func setupView(cityName: String, currentDay: String, weatherIconId: Int, temp: String, wind: String, humidity: String) {
        cityNameLabel.text = cityName
        currentDayLabel.text = currentDay
        tempLabel.text = temp + " " + "°С"
        windLabel.text = wind  + " " + "m/s"
        humidityLabel.text = humidity + " " + "%"
    }
}

