//
//  GetWeatherInfoRequest.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 21.07.2022.
//

import Foundation
import CoreLocation

struct GetWeatherInfoRequest: NetworkRequestProtocol {
    var scheme: String = NetworkConstants.scheme
    var host: String = NetworkConstants.host
    var path: String = NetworkConstants.Path.weather.rawValue
    var parameters: [URLQueryItem] = [
        URLQueryItem(name: "appid", value: NetworkConstants.apiKey),
        URLQueryItem(name: "units", value: "metric")
    ]
    var method: NetworkConstants.Method = .GET
    var httpAdditionalHeader: [String : String] = [:]
    init(lat: CLLocationDegrees, lon: CLLocationDegrees) {
        parameters.append(URLQueryItem(name: "lat", value: "\(lat)"))
        parameters.append(URLQueryItem(name: "lon", value: "\(lon)"))
    }
}
