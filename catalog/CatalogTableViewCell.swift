//
//  CatalogTableViewCell.swift
//  catalog
//
//  Created by 刘文奇 on 16/3/28.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

class CatalogTableViewCell: UITableViewCell {
    var view:CatalogProductView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let viewFrame = CGRect(x: 0, y: 0, width: self.contentView.bounds.size.width, height: self.contentView.bounds.size.height)
        
        view = CatalogProductView(frame: viewFrame)
        contentView.addSubview(view)
    }

    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    func setProduct(prod:Product)
    {
        view.setProduct(prod)
    }
    
}
