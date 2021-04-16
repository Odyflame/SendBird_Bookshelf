//
//  Note.swift
//  SendBird
//
//  Created by Hanteo on 2021/04/15.
//

import Foundation

public struct NoteData {
    let isbn13: String?
    let note: String?
}

extension NoteData {
    public init() {
        isbn13 = ""
        note = ""
    }
}
