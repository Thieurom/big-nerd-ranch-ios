//
//  TagDataSource.swift
//  Photorama
//
//  Created by Doan Le Thieu on 4/14/18.
//  Copyright © 2018 Doan Le Thieu. All rights reserved.
//

import UIKit
import CoreData

class TagDataSource: NSObject, UITableViewDataSource {
    
    var tags = [Tag]()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let tag = tags[indexPath.row]
        
        cell.textLabel?.text = tag.name
        
        return cell
    }
}
