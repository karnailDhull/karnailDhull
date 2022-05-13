//
//  ListOfNotesTableViewController.swift
//  MapView
//
//  Created by Karnail Singh on 13/02/22.
//

import UIKit

class ListOfJournalingTableViewController: UITableViewController {

    let journalViewModel = JournalViewModel.sharedNoteViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journalViewModel.journalingNoteCollection().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notes = journalViewModel.journalingNoteCollection()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as?
                                                        JournalingTableViewCell else { return UITableViewCell() }
        cell.journalTitleLabel.text = notes[indexPath.row].journalTitle
        cell.journalTextLabel.text = notes[indexPath.row].journalDescription
        cell.journalDateLabel.text =
            JournalingDataHelper.convertDate(date: Date.init(seconds: notes[indexPath.row].journalTimeStamp))
        return cell
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCreateNoteSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let noteUUID = journalViewModel.getJournalingUUID(at: indexPath)
                let noteModel = journalViewModel.readJournalingNote(with: noteUUID)
                let controller = (segue.destination) as? CreateNewJournalViewController
                controller?.changingModel = noteModel
            }
        }
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteUUID = journalViewModel.getJournalingUUID(at: indexPath)
            journalViewModel.removeJournalingNote(journalIdToBeDeleted: noteUUID)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {

        }
    }

    @IBAction func editJournalingNotes(_ sender: Any) {

    }

}
