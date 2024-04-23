//
//  Endpoints.swift
//
//
//  Created by Илья Шаповалов on 21.03.2024.
//

import Foundation

//https://newsdata.io/api/1/news?language=en&category=domestic &apikey=pub_40669167f5b9c344181f2c7e28f917505ffd7

extension Endpoint {
    
    enum ApiKeys {
        static let one = "pub_40669167f5b9c344181f2c7e28f917505ffd7"
        static let two = "pub_40710f81e68e7061f7ed766760a42acbb6b47"
        static let zwo = "pub_408981f06abc675eb60cc5f9449018e343c34"
    }
    static func get() -> Endpoint { Endpoint(method: .GET) }
    
    static func latestNews(lang: String, categories: String) -> Self {
        Endpoint.get()
            .queryItems {
                URLQueryItem(name: "apikey", value: ApiKeys.one)
                URLQueryItem(name: "language", value: lang)
                URLQueryItem(name: "category", value: categories)
            }
    }
    
    static func recommendedNews(categories: String, lang: String) -> Self {
        Endpoint.get()
            .queryItems {
                URLQueryItem(name: "apikey", value: ApiKeys.two)
                URLQueryItem(name: "language", value: lang)
                URLQueryItem(name: "category", value: categories)
            }
    }
    
    static func newsWith(searchText: String) -> Self {
        Endpoint.get()
            .queryItems {
                URLQueryItem(name: "apikey", value: ApiKeys.zwo)
                URLQueryItem(name: "q", value: searchText)
            }
    }
}
