//
//  ItemStore.swift
//  Homepwner
//
//  Created by Doan Le Thieu on 3/11/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems = [Item]()
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
}
