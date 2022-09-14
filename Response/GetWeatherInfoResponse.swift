//
//  GetWeatherInfoResponce.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 21.07.2022.
//

import Foundation

struct GetWeatherInfoResponse: Codable {

    let list: [ListInfo]
    let city: CityInfo
}

struct CityInfo: Codable {
    let cityId: Int
    let name: String
    let coord: Coord
    let country: String
//    let population: Int
//    let timezone: Int
//    let sunrise: Int
//    let sunset: Int
    
    enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case name
        case coord
        case country
//        case population
//        case timezone
//        case sunrise
//        case sunset
    }
}

struct Coord: Codable {
    let lat: Float
    let lon: Float
}

struct ListInfo: Codable {
    let dt: Int
    let main: MainInfo
    let weather: [WeatherInfo]
    let clouds: CloudsInfo
    let wind: WindInfo
//    let visibility: Int
//    let pop: Float
    let rain: RainInfo?
//    let sys: SysInfo
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
//        case visibility
//        case pop
        case rain
//        case sys
        case dtTxt = "dt_txt"
    }
}

struct MainInfo: Codable {
    let temp: Float
//    let feelsLike: Float
    let tempMin: Float
    let tempMax: Float
//    let pressure: Float
//    let seaLevel: Float
//    let grndLevel: Float
    let humidity: Float
    let tempKf: Float
    
    enum CodingKeys: String, CodingKey {
        case temp
//        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
//        case pressure
//        case seaLevel = "sea_level"
//        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct WeatherInfo: Codable {
    let weatherId: Int
    let mainWeather: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherId = "id"
        case mainWeather = "main"
        case description
        case icon
    }
}

struct CloudsInfo: Codable {
    let all: Int
}

struct WindInfo: Codable {
    let speed: Float
    let deg: Int
//    let gust: Float
}

struct RainInfo: Codable {
    let hourlyForecast: Float?
    
    enum CodingKeys: String, CodingKey {
        case hourlyForecast = "3h"
    }
}

//struct SysInfo: Codable {
//    let pod: String
//}





