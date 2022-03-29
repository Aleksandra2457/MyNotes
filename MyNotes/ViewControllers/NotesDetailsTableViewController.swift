//
//  NotesDetailsTableViewController.swift
//  MyNotes
//
//  Created by Александра Лесовская on 29.03.2022.
//

import UIKit

class NotesDetailsTableViewController: UITableViewController {
    
    @IBOutlet var notesNameTextField: UITextField!
    @IBOutlet var notesDescriptionTextView: UITextView!
    
    var delegate: NotesDetailsDelegate?
    var note: Note?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func dismissDetailsTableViewController() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
    }
    
    private func setupUI() {
        notesNameTextField.text = note?.title ?? ""
        notesDescriptionTextView.text = note?.description ?? ""
    }
    
}
