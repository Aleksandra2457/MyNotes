//
//  Note.swift
//  MyNotes
//
//  Created by Александра Лесовская on 28.03.2022.
//

import Foundation

struct Note {
    var title = ""
    var description = ""
    let id = UUID()
    
    static func returnExampleNote() -> Note {
        Note(title: "Моя заметка", description: "Создана 28.03.2022")
    }
}
