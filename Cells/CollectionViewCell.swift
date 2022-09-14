//
//  CollectionViewCell.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 26.07.2022.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var weatherImage: UIImageView!
    @IBOutlet private var tempLabel: UILabel!
    
    private var viewModel = MainViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setup(_ model: SecondBlock) {
        timeLabel.text = viewModel.getDayForCollectionView(Date(timeIntervalSince1970: Double(model.dateString) ?? 1970))
        tempLabel.text = model.temp + " " + "°С"
        viewModel.setupWeatherImage(weatherId: model.weatherId, image: weatherImage)
    }
}
