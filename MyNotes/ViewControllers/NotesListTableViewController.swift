//
//  NotesListTableViewController.swift
//  MyNotes
//
//  Created by Александра Лесовская on 28.03.2022.
//

import UIKit

protocol NotesDetailsDelegate {
    func getNote(_ note: Note)
}

class NotesListTableViewController: UITableViewController {
    
    //MARK: - Private Properties
    private var notes: [Note] = [Note.returnExampleNote()]

    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem?.image = UIImage(systemName: "line.3.horizontal")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToChangeSelectedNote", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToChangeSelectedNote" {
            guard let navigationVC = segue.destination as? UINavigationController else { return }
            guard let notesDetailsVC = navigationVC.topViewController as? NotesDetailsTableViewController else { return }
            guard let indexpath = tableView.indexPathForSelectedRow else { return }
            notesDetailsVC.note = notes[indexpath.row]
            notesDetailsVC.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: . automatic)
        }
    }
    
    //MARK: - IB Actions
    @IBAction func editBarButtonPressed(sender: UIBarButtonItem) {
        let tableIsEditing = tableView.isEditing
        tableView.setEditing(!tableIsEditing, animated: true)
    }
    
}

extension NotesListTableViewController: NotesDetailsDelegate {
    func getNote(_ note: Note) {
        notes.append(note)
    }
}
