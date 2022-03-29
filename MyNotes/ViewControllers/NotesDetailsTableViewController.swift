//
//  NotesDetailsTableViewController.swift
//  MyNotes
//
//  Created by Александра Лесовская on 29.03.2022.
//

import UIKit

class NotesDetailsTableViewController: UITableViewController {
    
    //MARK: - IB Outlets
    @IBOutlet var notesNameTextField: UITextField!
    @IBOutlet var notesDescriptionTextView: UITextView!
    
    //MARK: - Public Properties
    var note: Note!

    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        notesNameTextField.delegate = self
        setupUI()
        updateSaveButtonState()
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
    
    private func setupUI() {
        notesNameTextField.text = note?.title ?? ""
        notesDescriptionTextView.text = note?.description ?? ""
    }
    
    //MARK: - Private Methods
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func updateSaveButtonState() {
        guard let notesName = notesNameTextField.text,
              !notesName.isEmpty && notesName.count >= 1 else {
                  navigationItem.rightBarButtonItem?.isEnabled = false
                  return
              }
        navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
}

extension NotesDetailsTableViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
}
