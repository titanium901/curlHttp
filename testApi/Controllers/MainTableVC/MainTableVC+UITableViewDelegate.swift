//
//  MainTableVC+UITableViewDelegate.swift
//  testApi
//
//  Created by Yury Popov on 24/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import UIKit

extension MainTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let userEntry = userDates[indexPath.row]
        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as? DetailVC else { return }
        detailVC.userEntry = userEntry
        present(detailVC, animated: true, completion: nil)
    }
}
