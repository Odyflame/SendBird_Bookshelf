//
//  Book.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/20.
//

import Foundation

struct BooksData: Codable, Hashable {
    let error: String
    let total: String
    let page: String?
    let books: [Book]?
}

struct Book: Codable, Hashable {
    let title: String?
    let subtitle: String?
    let isbn13: String?
    let price: String?
    let image: String?
    let url: String?
    
    let raitng: String?
    let pages: String?
    let year: String?
    let desc: String?
    let authors: String?
    let publisher: String?
}

