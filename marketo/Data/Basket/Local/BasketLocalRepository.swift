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
                print("helllooooo")
                // TODO: check ERROR TYPE if empty type then create new basket else throw the error
                let basket = Basket(context: self.persistenceManager.context)
                // TODO: Initalize basket
                persistenceManager.save()
                completion(Result{
                    return basket
                })
            }
        }
    }

    
    func getBasket(_ completion: (Result<Basket>) -> Void) {
        let baskets = persistenceManager.fetch(Basket.self)
        
        if(baskets.isEmpty){
            let basket = Basket(context: persistenceManager.context)
            persistenceManager.save()
            completion(Result{
                return basket
            })
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
    
    func removeProduct(productId:Int,completion:@escaping (Result<Bool>)->Void){
        getBasket { response in
            switch response {
            case .success(let basket):
                
                if let products = basket.products as? Set<ProductInBasket>, products.count > 0 {
                    let filteredProduct = products.filter{ $0.productId == productId}
                    if filteredProduct.count > 0 {
                        basket.removeFromProducts(filteredProduct.first!)
                        self.persistenceManager.save()
                        completion(Result{
                            return true
                        })
                    }else {
                        completion(Result{
                            return false
                        })
                    }
                } else {
                    completion(Result{
                        return false
                    })
                }
                
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
                print("failed here")
                completion(Result{
                    throw error
                })
            }
        }
    }
    
    func addProduct(product:Product,completion:@escaping (Result<Bool>)->Void){
        print("adding to basket")
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
    
    func isBasketProduct(productId: Int, completion:@escaping (Result<Bool>)->Void) {
        getBasket { response in
            switch response {
            case .success(let basket):
                
                if let products = basket.products as? Set<ProductInBasket>, products.count > 0 {
                    let filteredProduct = products.filter{ $0.productId == productId}
                    if filteredProduct.count > 0 {
                        completion(Result{
                            return true
                        })
                    }else {
                        completion(Result{
                            return false
                        })
                    }
                } else {
                    completion(Result{
                        return false
                    })
                }
                
            case .failure(let error):
                completion(Result{
                    throw error
                })
            }
        }

    }
    
    func buildProductInBasket(product:Product) -> ProductInBasket {
        let productInBasket = ProductInBasket(context: persistenceManager.context)
        productInBasket.productId = Int32(product.id)
        productInBasket.name = product.name
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
