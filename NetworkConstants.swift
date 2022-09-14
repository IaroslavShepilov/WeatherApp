//
//  NetworkConstants.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 21.07.2022.
//

import Foundation

public struct NetworkConstants {
 
    public enum Method: String {
        case GET = "GET"
        case POST = "POST"
    }
    
    public enum Path: String {
        case weather = "/data/2.5/forecast"
    }

    public static let scheme = "https"
    public static let host = "api.openweathermap.org"
    public static let apiKey = "fe3cf0f8e5ede97ee317b3dd0c848517"
    
}

