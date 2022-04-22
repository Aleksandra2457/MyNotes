//
//  Extension UIAlertController.swift
//  MyNotes
//
//  Created by Александра Лесовская on 22.04.2022.
//

import Foundation

import UIKit

extension UIAlertController {
    
    static func createAlertController(withTitle title: String) -> UIAlertController {
        UIAlertController(title: title, message: "Название является обязательным", preferredStyle: .alert)
    }
    
    func action(note: Note?, completion: @escaping (String, String) -> Void) {
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let newTitle = self.textFields?.first?.text,
                  let newSubtitle = self.textFields?.last?.text else { return }
            guard !newTitle.isEmpty else { return }
            completion(newTitle, newSubtitle)
        }
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { titleTextField in
            titleTextField.placeholder = "Название заметки"
            titleTextField.text = note?.title
        }
        addTextField { subtitleTextField in
            subtitleTextField.placeholder = "Описание"
            subtitleTextField.text = note?.subtitle
        }
    }
}
