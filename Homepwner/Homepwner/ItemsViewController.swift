//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Doan Le Thieu on 3/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let index = indexPath.row
        
        if index == itemStore.allItems.count {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
            
        } else {
            let item = itemStore.allItems[index]
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "\(item.valueInDollars)"
        }
        
        return cell
    }
}
