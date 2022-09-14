//
//  NetworkService.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 21.07.2022.
//

import Foundation

public struct NetworkService {
    public static func request<T: Codable>(router: NetworkRequestProtocol, completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        if (!router.parameters.isEmpty) {
            components.queryItems = router.parameters
        }
        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL(urlPath: router.path)))
            return
        }
       
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = router.httpAdditionalHeader
        let session = URLSession(configuration: config)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard response != nil else {
                completion(.failure(NetworkError.emptyResponse(urlPath: url.absoluteString)))
                return
            }
            guard let responseData = data else {
                completion(.failure(NetworkError.emptyResponseData(urlPath: url.absoluteString)))
                return
            }
            do {
                if let str = String(data: responseData, encoding: .utf8) {
//                    print(str)
                }
                let responseObject = try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(responseObject))
            } catch let error {
                completion(.failure(error))
            }
         }
         dataTask.resume()
     }
}
