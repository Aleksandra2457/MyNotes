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
        notesNameTextField.layer.cornerRadius = 12
        notesDescriptionTextView.layer.cornerRadius = 12
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
    
    @IBAction func notesTitleIsChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        notesNameTextField.text = note?.title ?? ""
        notesDescriptionTextView.text = note?.description ?? ""
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
