//
//  MasterViewController.swift
//  catalog
//
//  Created by 刘文奇 on 16/3/23.
//  Copyright © 2016年 liuwq. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController,UISearchResultsUpdating,UISearchBarDelegate {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    var prods = [[Product]]()
    var searchController:UISearchController!
    var filteredProducts = [Product]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        //set the title
        self.title = "Products"
        

        //configure the search controller
        searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.scopeButtonTitles = ["Design", "Industrial", "Tool", "Spirit"]
        self.searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        self.tableView.tableHeaderView = self.searchController.searchBar
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        
     
        let db = DBAccess()
        db.initializeDatabase()
        let productsTemp = db.getAllProducts()
        let indexedCollation = UILocalizedIndexedCollation.currentCollation()
        
        //Iterate over the products, populating their section number
        for prod in productsTemp{
            let section = indexedCollation.sectionForObject(prod as AnyObject,collationStringSelector:Selector("name"))
            prod.section = section
        }
        
        //Get the count of the number of sections
        let sectionCount = indexedCollation.sectionTitles.count
        
       var sectionsArray = [[Product]]()
        
        for _ in 0 ..< sectionCount{
            sectionsArray.append([Product]())
        }
        
        for prod in productsTemp{
            sectionsArray[prod.section].append(prod)
        }
        
        //sort the products
        for products in sectionsArray{
            //let products = products as! [AnyObject]
            let sortedProducts = indexedCollation.sortedArrayFromArray(products as [AnyObject], collationStringSelector: Selector("name")) as! [Product]
            prods.append(sortedProducts)
        }
        
        
        
        db.closeDatabase()
    }

    
    //MARK:  for protocol UISearchResultsUpdating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let text = searchController.searchBar.text{
            var products = [Product]()
            for productsInSection in prods{
                for product in productsInSection{
                    products.append(product)
                }
            }
            
            self.filteredProducts = products.filter({ (prod) -> Bool in
                let scope = self.searchController.searchBar.scopeButtonTitles?[self.searchController.searchBar.selectedScopeButtonIndex]
               return  (prod.name?.lowercaseString.containsString(text.lowercaseString))! && (scope == nil || (prod.manufacturer?.lowercaseString.containsString((scope?.lowercaseString)!))!)
            })
            
            self.tableView.reloadData()
        }
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        //self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                var product:Product
                if self.searchController.active == true && self.searchController.searchBar.text != ""{
                    product = filteredProducts[indexPath.row]
                }else
                {
                    product = prods[indexPath.section][indexPath.row]
                }
                
                let dvc = segue.destinationViewController as! DetailViewController
                dvc.detailItem = product

            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        if self.searchController.active == true && self.searchController.searchBar.text != ""{
            return 1
        }else{
            return prods.count
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.searchController.active  && self.searchController.searchBar.text != ""{
            return filteredProducts.count
        }else{
            return prods[section].count

        }
        
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dvc = storyboard.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        self.detailViewController = dvc
        
        if self.searchController.active && self.searchController.searchBar.text != ""{
            self.detailViewController?.detailItem = filteredProducts[indexPath.row]
            
        }else{
            self.detailViewController?.detailItem = prods[indexPath.section][indexPath.row]

        }
        
        self.navigationController?.pushViewController(self.detailViewController!, animated: true)
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier(Constants.CELL_IDENTIFIER) as! CatalogTableViewCell?
        
        if cell == nil{
           cell = CatalogTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: Constants.CELL_IDENTIFIER)
            
        }
        
         var prod:Product?
        if self.searchController.active && self.searchController.searchBar.text != ""{
            prod = filteredProducts[indexPath.row]
        }else{
            prod = prods[indexPath.section][indexPath.row]

        }
        cell!.setProduct(prod!)
        
        return cell!
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        //set up the index titles from the UILocalizationIdexedCollation
        if self.searchController.active && self.searchController.searchBar.text != ""{
            return nil
        }else{
            return UILocalizedIndexedCollation.currentCollation().sectionIndexTitles
        }

    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return UILocalizedIndexedCollation.currentCollation().sectionForSectionIndexTitleAtIndex(index)
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if prods[section].count > 0{
            return UILocalizedIndexedCollation.currentCollation().sectionTitles[section]
        }
        
        return nil
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}

