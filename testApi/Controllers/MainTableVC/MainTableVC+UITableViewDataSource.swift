//
//  MainTableVC + UITableViewDataSource.swift
//  testApi
//
//  Created by Yury Popov on 24/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit


extension MainTableVC: UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell")! as! UserCell
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    func configure(_ cell: UserCell, forItemAt indexPath: IndexPath) {
        let userEntry = userDates[indexPath.row]
        if let userDa = userEntry.da, let userDm = userEntry.dm {
            let newTimeDa = Date(timeIntervalSince1970: TimeInterval(userDa)!)
            let newTimeDm = Date(timeIntervalSince1970: TimeInterval(userDm)!)
            cell.daLabel.text = newTimeDa.description
            if userEntry.da != userEntry.dm {
                cell.dmLabel.text = newTimeDm.description
            }
        }
        guard let bodyText = userEntry.body else { return }
        if bodyText.count > 200 {
            cell.bodyLabel.text = String(bodyText.prefix(200))
        } else {
            cell.bodyLabel.text = bodyText
        }
        
    }

    
    
}


