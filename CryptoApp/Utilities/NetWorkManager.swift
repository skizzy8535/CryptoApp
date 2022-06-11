//
//  NetWorkingManager.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/2/13.
//

import Foundation
import Combine


class NetWorkingManager{
    
    static func downloadCoins(urlString:URL) -> AnyPublisher<Data,Error>{
       
        URLSession.shared.dataTaskPublisher(for: urlString)
                                .subscribe(on: DispatchQueue.global(qos: .background))
                                .tryMap({ (outputCoinData) -> Data in
                                    
                                    guard let coinDataResponse = outputCoinData.response as? HTTPURLResponse ,
                                    coinDataResponse.statusCode >= 200 && coinDataResponse.statusCode < 405 else{
                                        throw URLError(.badServerResponse)
                                    }
                                    
                                    return outputCoinData.data
                                })
                                .receive(on: DispatchQueue.main)
                                .eraseToAnyPublisher()
        
    }
    
    
    
    
    static func completionHandler(completion:Subscribers.Completion<Error>){
            switch completion {
            case .finished:
                print("Donwload Succeed")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    
    
    }
    

