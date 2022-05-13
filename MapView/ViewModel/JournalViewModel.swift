//
//  NoteViewModel.swift
//  MapView
//
//  Created by Karnail Singh on 13/02/22.
//

import Foundation
import CoreData

class JournalViewModel {

    static let sharedNoteViewModel = JournalViewModel()
    let viewContext = CoreDataManager.coreDataManager.viewContext

    private init() {}

    func addJournalingNote(noteToBeAdded: JournalModel) {
        JournalingCoreDataHelper.createNoteInCoreData(managedObjectContext: viewContext, noteToBeCreated: noteToBeAdded)
    }

    func journalingNoteCollection() -> [JournalModel] {
        return JournalingCoreDataHelper.readNotesFromCoreData(managedObjectContext: viewContext)
    }

    func readJournalingNote(with noteUID: UUID) -> JournalModel? {

       let noteModel = JournalingCoreDataHelper.readNoteFromCoreData(
                noteIdToBeRead: noteUID,
                fromManagedObjectContext: viewContext)
        return noteModel
    }

    func changeJournalingNote(noteToBeChanged: JournalModel) {
        JournalingCoreDataHelper.changeNoteInCoreData(
            noteToBeChanged: noteToBeChanged,
            inManagedObjectContext: viewContext)
    }

    func removeJournalingNote(journalIdToBeDeleted: UUID) {
        JournalingCoreDataHelper.deleteJournalFromCoreData(journalIdToBeDeleted: journalIdToBeDeleted,
                                                           fromManagedObjectContext: viewContext)
           
    }
    
    func getJournalingUUID(at indexPath: IndexPath) -> UUID {
        let selectedNote = journalingNoteCollection()[indexPath.row]
        let noteUUID = selectedNote.journalId
        return noteUUID
    }
}
