//
//  OpenAPI.swift
//  ExerciseGuide
//
//  Created by 이인호 on 10/31/24.
//

import Foundation
import Combine

final class OpenAPI {
    private let baseURL: String
    private let apiKey: String
    
    init() {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String, let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("Not set in plist")
        }
        
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
    
    func getExerciseGuide() -> AnyPublisher<[Result], Never> {
        let urlString = "\(baseURL)/TODZ_VDO_TRNG_GUIDE_I"
        var components = URLComponents(string: urlString)!
        components.queryItems = [
            URLQueryItem(name: "serviceKey", value: apiKey),
            URLQueryItem(name: "pageNo", value: "1"),
            URLQueryItem(name: "numOfRows", value: "10"),
            URLQueryItem(name: "resultType", value: "json")
        ]
        
        guard let url = components.url else {
            fatalError("Invalid URL")
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Raw JSON data:", jsonString)
//                }
            })
            .decode(type: APIResponse.self, decoder: JSONDecoder())
            .map { result -> [Result] in
                let items = result.response.body.items.item
                
                return items
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
