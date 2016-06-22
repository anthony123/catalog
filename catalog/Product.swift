//
//  Product.swift
//  catalog
//
//  Created by 刘文奇 on 16/3/23.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import Foundation

class Product:NSObject{
    var id:Int!
    var name:String?
    var manufacturer:String?
    var details: String?
    var price:Double?
    var quantity:Int32?
    var countryOfOrigin:String?
    var image:String?
    var section:Int!
    
//    init(prod:Product){
//        id = prod.id
//        name = prod.name
//        manufacturer = prod.manufacturer
//        details = prod.details
//        price = prod.price
//        quantity = prod.quantity
//        countryOfOrigin = prod.countryOfOrigin
//        image = prod.image
//    }
    init(id:Int, name:String, manufacturer:String, details:String, price:Double, quantity:Int32, country:String, image:String, section:Int){
        super.init()
        self.id = id
        self.name = name;
        self.manufacturer = manufacturer
        self.details = details
        self.price = price
        self.quantity = quantity
        self.countryOfOrigin = country
        self.image = image
        self.section = section
    }
}










