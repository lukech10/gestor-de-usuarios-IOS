//
//  User.swift
//  rutas
//
//  Created by alumnos on 26/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation

//struct User: Decodable {
//    let email: String
//    let password: String
//}

//final class User: Codable{
//    let id: Int?
//    let name: String
//    let email: String
//    let password: String
//}

class User: Encodable,Decodable{
    
    let user: String
    let pass: String?
    
    init(user: String, pass: String) {
            self.user = user
            self.pass = pass
        }
}
