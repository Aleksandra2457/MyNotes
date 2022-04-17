//
//  NotesListTableViewController.swift
//  MyNotes
//
//  Created by Александра Лесовская on 28.03.2022.
//

import UIKit

class NotesListTableViewController: UITableViewController {
    
    //MARK: - Public Properties
    var note: Note!
    
    //MARK: - Private Properties
    private var notes: [Note] = [Note.returnExampleNote()]
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "line.3.horizontal")
    }
    
    //MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let note = notes[indexPath.row]
        content.text = note.title
        content.secondaryText = note.description
        cell.contentConfiguration = content
        return cell
    }
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToChangeSelectedNote", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: . automatic)
        }
    }
    
    //MARK: - Override Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToChangeSelectedNote" {
            guard let navigationVC = segue.destination as? UINavigationController else { return }
            guard let notesDetailsVC = navigationVC.topViewController as? NotesDetailsViewController else { return }
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            notesDetailsVC.note = notes[indexpath.row]
        }
    }
    
    //MARK: - IB Actions
    @IBAction func editBarButtonPressed(sender: UIBarButtonItem) {
        let tableIsEditing = tableView.isEditing
        tableView.setEditing(!tableIsEditing, animated: true)
    }
    
    @IBAction func unwindFor(segue: UIStoryboardSegue) {
        if segue.identifier == "SaveUnwind" {
            guard let source = segue.source as? NotesDetailsViewController,
                  let note = source.note else { return }
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                notes[selectedIndexPath.row] = note
                tableView.reloadRows(at: [selectedIndexPath], with: .automatic)
            } else {
                notes.append(note)
                tableView.reloadData()
            }
        }
    }
    
}
