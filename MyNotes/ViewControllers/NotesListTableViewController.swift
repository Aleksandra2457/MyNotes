//
//  NotesListTableViewController.swift
//  MyNotes
//
//  Created by Александра Лесовская on 28.03.2022.
//

import UIKit
import CoreData

class NotesListTableViewController: UITableViewController {
    
    // MARK: - Public Properties
    var notes: [Note] = []
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "line.3.horizontal")
        TemplateDataManager.shared.createTemplateData {
            self.tableView.reloadData()
        }
        fetchData()
    }
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        let note = notes[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = note.title
        content.secondaryText = note.subtitle
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = notes[indexPath.row]
        showAlert(note: note) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            CoreDataManager.shared.delete(note)
        }
    }
    
    //MARK: - IB Actions
    @IBAction func editBarButtonPressed(sender: UIBarButtonItem) {
        let tableIsEditing = tableView.isEditing
        tableView.setEditing(!tableIsEditing, animated: true)
    }
    
    @IBAction func addNewTask() {
        showAlert()
    }
    
    private func save(notesTitle: String, notesSubtitle: String) {
        CoreDataManager.shared.create(notesTitle, notesSubtitle) { note in
            self.notes.append(note)
            self.tableView.insertRows(
                at: [IndexPath(row: self.notes.count - 1, section: 0)],
                with: .automatic
            )
        }
    }

    private func fetchData() {
        CoreDataManager.shared.fetchData { result in
            switch result {
            case .success(let notes):
                self.notes = notes
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

// MARK: - Alert Controller
extension NotesListTableViewController {
    
    private func showAlert(note: Note? = nil, completion: (() -> Void)? = nil) {
        let title = note != nil ? "Редактирование заметки" : "Новая заметка"
        let alert = UIAlertController.createAlertController(withTitle: title)
        
        alert.action(note: note) { (notesTitle, notesSubtitle) in
            if let note = note, let completion = completion {
                CoreDataManager.shared.update(note, newTitle: notesTitle, newSubtitle: notesSubtitle)
                completion()
            } else {
                self.save(notesTitle: notesTitle, notesSubtitle: notesSubtitle)
            }
        }
        
        present(alert, animated: true)
    }
}

