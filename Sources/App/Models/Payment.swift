//
//  Payment.swift
//  AppForgeServer
//
//  Created by Aliaksandr Yashchuk on 11/7/24.
//

import Vapor
struct Payment: Content {
    let amount: Double
    let currency: String
    let description: String
}
