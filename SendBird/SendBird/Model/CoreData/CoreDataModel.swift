//
//  CoreDataModel.swift
//  SendBird
//
//  Created by Hanteo on 2021/04/15.
//

import UIKit
import CoreData

protocol CoreDataModelInputs {
    func getNote()
    func add(newNote: NoteData) -> (Bool, Error?)
    func delete(isbn13: String) -> (Bool, Error?)
    func update(updateNote: NoteData) -> (Bool, Error?)
}

protocol CoreDataModelOutputs {
    
}
