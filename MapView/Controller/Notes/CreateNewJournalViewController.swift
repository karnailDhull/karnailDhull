//
//  CreateNewNoteViewController.swift
//  MapView
//
//  Created by Karnail Singh on 13/02/22.
//

import UIKit

class CreateNewJournalViewController: UIViewController {

    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextTextView: UITextView!
    @IBOutlet weak var noteDoneButton: UIButton!
    @IBOutlet weak var noteDateLabel: UILabel!

    private let noteCreationTimeStamp: Int64 = Date().toSeconds()
    var changingModel: JournalModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    func configureView() {
        if let changingNote = self.changingModel {
            // in change mode: initialize for fields with data coming from note to be changed
            noteDateLabel.text = JournalingDataHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
            noteTextTextView.text = changingNote.journalDescription
            noteTitleTextField.text = changingNote.journalTitle
            // enable done button by default
            noteDoneButton.isEnabled = true
        } else {
            noteDateLabel.text = JournalingDataHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
        }
    }

    @IBAction func noteTitleChanged(_ sender: UITextField, forEvent event: UIEvent) {

    }

    @IBAction func doneButtonClicked(_ sender: UIButton, forEvent event: UIEvent) {
        // distinguish change mode and create mode
        if changingModel != nil {
           let changedNoteModel = JournalModel(journalId: changingModel!.journalId, journalTitle: noteTitleTextField.text!,
                      journalText: noteTextTextView.text,
                      journalTimeStamp: noteCreationTimeStamp)
            JournalViewModel.sharedNoteViewModel.changeJournalingNote(noteToBeChanged: changedNoteModel)

        } else {
            let note = JournalModel(journalTitle: noteTitleTextField.text!,
                                    journalText: noteTextTextView.text,
                                    journalTimeStamp: noteCreationTimeStamp)
            JournalViewModel.sharedNoteViewModel.addJournalingNote(noteToBeAdded: note)
        }
        self.navigationController?.popViewController(animated: true)
    }

    // Handle the text changes here
    func textViewDidChange(_ textView: UITextView) {
    }

}
