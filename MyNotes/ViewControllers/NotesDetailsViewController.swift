//
//  NotesDetailsViewController.swift
//  MyNotes
//
//  Created by Александра Лесовская on 17.04.2022.
//

import UIKit

class NotesDetailsViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var notesNameTextField: UITextField!
    @IBOutlet var notesDescriptionTextView: UITextView!
    
    //MARK: - Public Properties
    var note: Note!
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        notesDescriptionTextView.layer.cornerRadius = 5
        notesDescriptionTextView.layer.borderWidth = 0.1
        setupUI()
        updateSaveButtonState()
        notesNameTextField.addTarget(self, action: #selector(updateSaveButtonState), for: .editingChanged)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveUnwind" else { return }
        guard let notesTitle = notesNameTextField.text,
              let notesDescription = notesDescriptionTextView.text else { return }
        note = Note(title: notesTitle, description: notesDescription)
    }
    
    //MARK: - IB Actions
    @IBAction func cancelButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        notesNameTextField.text = note?.title ?? ""
        notesDescriptionTextView.text = note?.description ?? ""
    }
    
    @objc private func updateSaveButtonState() {
        guard let notesName = notesNameTextField.text,
              !notesName.isEmpty && notesName.count >= 1 else {
            navigationItem.rightBarButtonItem?.isEnabled = false
            return
        }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }

}
