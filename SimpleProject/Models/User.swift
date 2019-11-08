//
//  User.swift
//  SimpleProject
//
//  Created by Harut Mikichyan on 11/8/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import Foundation

class UserData: NSObject {
    var name: String
    var password: String
    @objc dynamic var score: Int

    init(name: String, password: String, score: Int = 0) {
        self.name = name
        self.password = password
        self.score = score
    }
}
