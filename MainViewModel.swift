//
//  MainViewModel.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 21.07.2022.
//

import Foundation
import CoreLocation
import UIKit

protocol MainViewModelProtocol {
    func updateWeatherInfo(response: MyStruct)
}

protocol MainViewModelProtocolForWeatherView {
    func updateMainWeaterView(response: [FirstBlock])
}

final class MainViewModel {
   
    var delegate: MainViewModelProtocol?
    var weatherViewDelegate: MainViewModelProtocolForWeatherView?
    func getWeather(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        NetworkService.request(router: GetWeatherInfoRequest(lat: lat, lon: lon)) { [weak self] (result: Result<GetWeatherInfoResponse, Error>) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    let firstBlockArray = response.list.enumerated().map { index, listInfo -> FirstBlock in
                        return FirstBlock(temp: "\(Int(listInfo.main.temp))", icon: "\(listInfo.weather.first?.icon ?? "")", speed: "\(listInfo.wind.speed)", humidity: "\(Int(listInfo.main.humidity))", dateString: "\(listInfo.dt)", weatherId: listInfo.weather.first?.weatherId ?? 0, cityName: response.city.name)
                    }
                    let secondBlockArray = response.list.enumerated().map { index, listInfo -> SecondBlock in
                        return SecondBlock(temp: "\(Int(listInfo.main.temp))", icon: "\(listInfo.weather.first?.icon ?? "")", dateString: "\(listInfo.dt)", weatherId: listInfo.weather.first?.weatherId ?? 0)
                    }
                    let thirdBlockArray = response.list.enumerated().map { index, listInfo -> ThirdBlock in
                        return ThirdBlock(dateString: "\(listInfo.dt)", tempMin: "\(Int(listInfo.main.tempMin))", tempMax: "\(Int(listInfo.main.tempMax))", icon: "\(listInfo.weather.first?.icon ?? "")", weatherId: listInfo.weather.first?.weatherId ?? 0, description: listInfo.weather.first?.description ?? "")
                    }
                    let resultFinalResult: MyStruct = MyStruct(firstBlockInfo: firstBlockArray, secondBlockInfo: secondBlockArray, thirdBlockInfo: thirdBlockArray)
                    self?.delegate?.updateWeatherInfo(response: resultFinalResult)
                    self?.weatherViewDelegate?.updateMainWeaterView(response: firstBlockArray)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupWeatherImage(weatherId: Int, image: UIImageView) {
        if weatherId == 800 {
            image.image = UIImage(named: "sun")
        }
        if weatherId > 199 && weatherId < 233 {
            image.image = UIImage(named: "thunderstorm")
        }
        if weatherId > 299 && weatherId < 322 {
            image.image = UIImage(named: "drizzle")
        }
        if weatherId == 500 {
            image.image = UIImage(named: "lightRain")
        }
        if weatherId == 501 {
            image.image = UIImage(named: "moderateRain")
        }
        if weatherId > 501 && weatherId < 505 {
            image.image = UIImage(named: "rain")
        }
        if weatherId == 511 {
            image.image = UIImage(named: "sleet")
        }
        if weatherId > 519 && weatherId < 532 {
            image.image = UIImage(named: "rain")
        }
        if weatherId > 599 && weatherId < 623 {
            image.image = UIImage(named: "snow")
        }
        if weatherId > 700 && weatherId < 782 {
            image.image = UIImage(named: "haze")
        }
        if weatherId == 801 {
            image.image = UIImage(named: "fewClouds")
        }
        if weatherId > 801 && weatherId < 805 {
            image.image = UIImage(named: "clouds")
        }
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "E, HH:mm"
        return formatter.string(from: inputDate)
    }
    
    func getDayForCollectionView(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d \n HH:mm"
        return formatter.string(from: inputDate)
    }
}

struct FirstBlock {
    let temp: String
    let icon: String
    let speed: String
    let humidity: String
    let dateString: String
    let weatherId: Int
    let cityName: String
}

struct SecondBlock {
    let temp: String
    let icon: String
    let dateString: String
    let weatherId: Int
}

struct ThirdBlock {
    let dateString: String
    let tempMin: String
    let tempMax: String
    let icon: String
    let weatherId: Int
    let description: String
}

struct MyStruct {
    let firstBlockInfo: [FirstBlock]
    let secondBlockInfo: [SecondBlock]
    let thirdBlockInfo: [ThirdBlock]
}
