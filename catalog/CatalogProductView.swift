//
//  CatalogProductView.swift
//  catalog
//
//  Created by 刘文奇 on 16/3/28.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

class CatalogProductView: UIView {
    var prod:Product!
     override init(frame: CGRect) {
        super.init(frame: frame)
        opaque = true
        backgroundColor = UIColor.whiteColor()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //draw the name label
        let productName = prod.name! as NSString
        let font = UIFont.systemFontOfSize(18)
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .ByTruncatingTail
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName: paraStyle]
        
        
        productName.drawAtPoint(CGPoint(x: 45.0, y: 0.0),withAttributes:attributes)
        
        //draw the manufacturer label
        let manufacturerName = prod.manufacturer! as NSString
        let manufacturerFont = UIFont.systemFontOfSize(12)
        let manufacturerColor = UIColor.darkGrayColor()
        let manufacturerAttributes = [NSFontAttributeName: manufacturerFont, NSForegroundColorAttributeName: manufacturerColor, NSParagraphStyleAttributeName:paraStyle]
        manufacturerName.drawAtPoint(CGPoint(x: 45, y: 25), withAttributes: manufacturerAttributes)
        
        //draw the price label
        let priceName = String(prod.price!) as NSString
        let priceFont = UIFont.systemFontOfSize(16)
        let priceColor = UIColor.blackColor()
        let priceAttributes = [NSFontAttributeName: priceFont, NSForegroundColorAttributeName: priceColor, NSParagraphStyleAttributeName: paraStyle]
        priceName.drawAtPoint(CGPoint(x: 200, y: 10), withAttributes: priceAttributes)
        
        //draw the image
        let imagePath = NSBundle.mainBundle().pathForResource(prod.image, ofType: Constants.IMAGE_TYPE)
        let image = UIImage(contentsOfFile: imagePath!)
        image?.drawInRect(CGRect(x: 0, y: 0, width: 40, height: 40))
        
        let countryPath = NSBundle.mainBundle().pathForResource(prod.countryOfOrigin, ofType: Constants.IMAGE_TYPE)
        let image1 = UIImage(contentsOfFile: countryPath!)
        image1?.drawInRect(CGRect(x: 260, y: 10, width: 20, height: 20))
        
    }
    
    func setProduct(inputProduct:Product)
    {
        if prod == nil || prod.name != inputProduct.name{
            
            prod = inputProduct
            setNeedsDisplay()
        }
    }
    
     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         //fatalError("init(coder:) has not been implemented")
     }
    
    
    
}
