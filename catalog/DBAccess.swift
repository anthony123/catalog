//
//  DBAccess.swift
//  catalog
//
//  Created by 刘文奇 on 16/3/23.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import Foundation

class DBAccess{
    var db:FMDatabase!
    init(){
        initializeDatabase()
    }
    
    func getAllProducts()->[Product]{
        var products = [Product]()
        
        
        let querySQL = "SELECT Product.Name, Manufacturer.Name, Product.Details, Product.Price, Product.QuantityOnHand, Country.Country, Product.Image FROM Product, Manufacturer, Country where Manufacturer.manufacturerID = Product.manufacturerID AND Product.CountryOfOriginID = Country.CountryID"
        
        if let result = db.executeQuery(querySQL, withArgumentsInArray: nil){
            while result.next(){
                let prod = Product(
                        id:0,
                        name: result.stringForColumnIndex(0),
                        manufacturer: result.stringForColumnIndex(1),
                        details: result.stringForColumn("details"),
                        price: result.doubleForColumn("price"),
                        quantity:result.intForColumn("quantityonhand"),
                        country:result.stringForColumn("country"),
                        image: result.stringForColumn("image"),
                        section:0)

                
                products.append(prod)
            }
        }
        
        return products
        
    }
    
    func initializeDatabase(){
        //get database file from application bundle
        let path = NSBundle.mainBundle().pathForResource(Constants.DBNAME, ofType: Constants.DBSUFFIX)
        
        //open the database
        db = FMDatabase(path: path)
        if db != nil{
            let state = db.open()
            if(state == false){
               print("Error: \(db.lastErrorMessage())")
            }
        }
        
        
    }
    
    func closeDatabase(){
        let state = db.close()
        if state == false{
            print("Error: \(db.lastErrorMessage())")
        }
    }
}