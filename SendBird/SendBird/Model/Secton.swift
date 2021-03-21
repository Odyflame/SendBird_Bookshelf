//
//  Secton.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/21.
//

import UIKit

class Section: Hashable {
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
    
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}

extension Section {
    static var allSections: [Section] = [
        Section(title: "New", books: [] ),
        Section(title: "Search", books: [])
    ]
 
}
