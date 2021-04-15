//
//  Secton.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/21.
//

import UIKit

class BookSection: Hashable {
    var id = UUID()
    var title: String
    var books: [Book]
    
    init(title: String, books: [Book]) {
        self.title = title
        self.books = books
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: BookSection, rhs: BookSection) -> Bool {
        lhs.id == rhs.id
    }
}

extension BookSection {
    static var allSections: [BookSection] = [
        BookSection(title: "New", books: [] ),
        BookSection(title: "Search", books: [])
    ]
}
