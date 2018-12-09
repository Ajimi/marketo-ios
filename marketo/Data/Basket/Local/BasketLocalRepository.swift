//
//  BasketLocalRepository.swift
//  marketo
//
//  Created by Othmen on 11/30/18.
//  Copyright © 2018 selim ajimi. All rights reserved.
//

import Foundation
import Alamofire

enum DataBaseError : Error {
    case EmptyError

}

typealias ProductsInBasket = [ProductInBasket]

class BasketLocalRepository: LocalRepository {
    

    
    
}

extension BasketLocalRepository{
    
    func createBasket(completion : (Result<Basket>) -> Void)  {
        getBasket { (response) in
            switch response {
            case .success(let currentBasket):
                
                completion(Result{
                    return currentBasket
                })
            case .failure(_):
                // TODO check ERROR TYPE if empty type then create new basket else throw the error
                let basket = Basket(context: self.persistenceManager.context)
                completion(Result{
                    return basket
                })
            }
        }
    }

    
    func getBasket(_ completion: (Result<Basket>) -> Void) {
        let baskets = persistenceManager.fetch(Basket.self)
        
        if(baskets.isEmpty){
            completion(Result{
                throw DataBaseError.EmptyError
            })
        }else{
            completion(Result{
                return baskets.first!
            })
        }
    }
    
    func getProductsInBasket(completion:@escaping (Result<ProductsInBasket>)->Void) {
        getBasket { response in
            switch response {
            case .success(let basket):
                //TO DO: add empty test
                if let products = basket.products {
                    completion(Result{
                        return products.allObjects as! ProductsInBasket
                    })
                } else {
                    completion(Result{
                        throw DataBaseError.EmptyError
                    })
                }
                
            case .failure(let error):
                completion(Result{
                    throw error
                })
            }
        }
    }
    
    func deleteProduct(product:ProductInBasket,completion:@escaping (Result<Bool>)->Void){
        getBasket { response in
            switch response {
            case .success(let basket):
                basket.removeFromProducts(product)
                self.persistenceManager.save()
                completion(Result{
                    return true
                })
            case .failure(let error):
                completion(Result{
                    throw error
                })
            }
        }
    }
    
    func deleteAll(completion:@escaping (Result<Bool>)->Void){
        getBasket { response in
            switch response {
            case .success(let basket):
                basket.removeFromProducts(basket.products!)
                self.persistenceManager.save()
                completion(Result{
                    return true
                })
            case .failure(let error):
                completion(Result{
                    throw error
                })
            }
        }
    }
    
    func addProduct(product:Product,completion:@escaping (Result<Bool>)->Void){
        getBasket { response in
            switch response {
            case .success(let basket):
                basket.addToProducts(buildProductInBasket(product: product))
                self.persistenceManager.save()
                completion(Result{
                    return true
                })
            case .failure(let error):
                completion(Result{
                    throw error
                })
            }
        }
    }
    
    func buildProductInBasket(product:Product) -> ProductInBasket {
        let productInBasket = ProductInBasket(context: persistenceManager.context)
        productInBasket.name = product.name
        productInBasket.id = product.id
        productInBasket.image = product.image
        return productInBasket
    }
    
    
    func modifyProductQuantity(for product:ProductInBasket,with value:Int,completion:@escaping (Result<Bool>)->Void){
        product.quantity = Int32(value)
        persistenceManager.save()
        completion(Result{
            return true
        })
    }

}
