//
//  TemplateDataManager.swift
//  MyNotes
//
//  Created by Александра Лесовская on 22.04.2022.
//

import Foundation

class TemplateDataManager {
    
    // MARK: - Static Properties
    static let shared = TemplateDataManager()
    
    // MARK: - Initializers
    private init() {}
    
    // MARK: - Public Methods
    func createTemplateData(completion: @escaping() -> Void) {
        if !UserDefaults.standard.bool(forKey: "templateDataHasBeenLoaded") {
            CoreDataManager.shared.create(
                "Тестовая заметка",
                "Ее можно удалить при помощи свайпа справа налево и при помощи кнопки слева наверху"
            )
            UserDefaults.standard.set(true, forKey: "templateDataHasBeenLoaded")
            completion()
        }
    }
    
}
