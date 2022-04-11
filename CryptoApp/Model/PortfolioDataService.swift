//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by 林祐辰 on 2022/3/11.
//

import Foundation
import CoreData

class PortfolioDataService{
    
    let container:NSPersistentContainer
    @Published var savedPortfolio:[Portfolio]=[]
    
    
    init(){
        container = NSPersistentContainer(name: "PortfoiloContainer")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Failed to load Core Data \(error)")
            }
            self.getPortfolio()
        }
    }
    
    
    func update(coin:CoinModel,amount:Double){
        if let portfolio = savedPortfolio.first(where: {$0.coinID == coin.id}) {
            if amount > 0 {
                updatePortfolio(entity: portfolio, amount: amount)
            }else{
                deletePortfolio(entity: portfolio)
            }
            
        }else{
            
            addPortfolio(coin: coin, amount: amount)
            
        }
    }
    

    
    
  private func getPortfolio(){
        let portfolioRequest = NSFetchRequest<Portfolio>(entityName: "Portfolio")
        do {
            savedPortfolio =  try container.viewContext.fetch(portfolioRequest)
        } catch let error {
            print("Failed to fetch portfoilo \(error)")
        }
    }
    
    private func addPortfolio(coin:CoinModel,amount:Double){
        let addedPortfolio = Portfolio(context: container.viewContext)
        addedPortfolio.amount = amount
        addedPortfolio.coinID = coin.id
        applyChanges()
    }
    
    
    private func updatePortfolio(entity:Portfolio,amount:Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func deletePortfolio(entity:Portfolio){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    
    private func applyChanges(){
        save()
        getPortfolio()
    }
    
    func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Failed to fetch portfoilo \(error)")
        }
    }
}


