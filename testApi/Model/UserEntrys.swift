//
//  User.swift
//  testApi
//
//  Created by Yury Popov on 24/09/2019.
//  Copyright © 2019 Iurii Popov. All rights reserved.
//

import Foundation

// MARK: - Users
struct UserEntrys: Codable {
    let status: Int = 1
    var data: [[Entry]]
}

// MARK: - Datum
struct Entry: Codable {
    let id, body, da, dm: String?
}
