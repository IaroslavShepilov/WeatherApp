//
//  NetworkRequestProtocol.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 21.07.2022.
//

import Foundation

public protocol NetworkRequestProtocol {
    var scheme: String { get set }
    var host: String { get set }
    var path: String { get set }
    var parameters: [URLQueryItem] { get set }
    var method: NetworkConstants.Method { get set }
    var httpAdditionalHeader: [String: String] { get }
}
