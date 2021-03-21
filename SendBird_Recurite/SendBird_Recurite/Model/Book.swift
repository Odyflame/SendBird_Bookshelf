//
//  Book.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/20.
//

import Foundation

struct BooksData: Codable {
    let total: String
}


struct Book: Codable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
}

