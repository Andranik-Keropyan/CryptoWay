//
//  NetworkManager.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import Foundation
import Moya
import SwiftUI

typealias ArraySuccess<T: Decodable> = (([T]) -> Void)
typealias ObjectSuccess<T: Decodable> = ((T) -> Void)
typealias ErrorClosure = (String) -> Void

class NetworkManager {
    private let provider = MoyaProvider<BackendApi>(plugins: [NetworkLoggerPlugin()])
    
    func getRate( success: ArraySuccess<CryptoModel>?, errorClosure: ErrorClosure?) {
        provider.request(.getRate) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try JSONDecoder().decode([CryptoModel].self, from: response.data)
                    success?(data)
                } catch let error {
                    errorClosure?(error.localizedDescription)
                    print(error)
                }
                
            case .failure(let error):
                print("Ошибка: \(error)")
                errorClosure?(error.localizedDescription)
            }
        }
    }
    
    func getNews(success: ObjectSuccess<NewsModel>?, errorClosure: ErrorClosure?) {
        provider.request(.getNews) { result in
            switch result {
            case .success(let response):
                do {
                    //                    let data = try JSONDecoder().decode(Wrapper<NewsModel>.self, from: response.data)
                    let data = try JSONDecoder().decode(NewsModel.self, from: response.data)
                    success?(data)
                    //                    print(data)
                } catch let error {
                    errorClosure?(error.localizedDescription)
                    print(error)
                }
                
                
            case .failure(let error):
                print("Ошибка: \(error)")
                errorClosure?(error.localizedDescription)
            }
        }
        
    }
}
