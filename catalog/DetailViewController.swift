//
//  DetailViewController.swift
//  catalog
//
//  Created by 刘文奇 on 16/3/23.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var NameLabel: UILabel!

    @IBOutlet weak var ManufacturerLabel: UILabel!
    
    @IBOutlet weak var DetailLabel: UILabel!
    
    @IBOutlet weak var PriceLabel: UILabel!
    

    @IBOutlet weak var QuantityLabel: UILabel!
    
    
    @IBOutlet weak var CountryLabel: UILabel!
    
    var detailItem: Product? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let product = self.detailItem {
            NameLabel?.text = product.name
            ManufacturerLabel?.text = product.manufacturer
            DetailLabel?.text = product.details
            PriceLabel?.text = String(product.price!)
            QuantityLabel?.text = String(product.quantity!)
            CountryLabel?.text = product.countryOfOrigin
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        self.title = NameLabel.text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

