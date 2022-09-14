//
//  CustomCellForOtherDayWeather.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 25.07.2022.
//

import UIKit

class CustomCellForOtherDayWeather: UITableViewCell {

    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var maxTempLabel: UILabel!
    @IBOutlet private var minTempLabel: UILabel!
    @IBOutlet private var weatherImage: UIImageView!

    private var viewModel = MainViewModel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
        
    static func nib() -> UINib {
        return UINib(nibName: "CustomCellForOtherDayWeather", bundle: nil)
    }
    
    func setupCustomCell(_ model: ThirdBlock) {
        maxTempLabel.text = " " + model.tempMax + " °С"
        minTempLabel.text = model.tempMin + " °С"
        dayLabel.text = viewModel.getDayForDate(Date(timeIntervalSince1970: Double(model.dateString) ?? 1970))
        viewModel.setupWeatherImage(weatherId: model.weatherId, image: weatherImage)
        weatherImage.highlightedImage?.withTintColor(.gray)
        dayLabel.highlightedTextColor = .systemBlue
        maxTempLabel.highlightedTextColor = .systemBlue
        minTempLabel.highlightedTextColor = .systemBlue
        let view = UIView()
        view.backgroundColor = UIColor.white
        selectedBackgroundView = view
    }
}
