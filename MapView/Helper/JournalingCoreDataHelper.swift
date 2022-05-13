//
//  NoteDataHelper.swift
//  MapView
//
//  Created by Karnail Singh on 14/02/22.
//

import Foundation
import CoreData

class JournalingCoreDataHelper {

   static func createNoteInCoreData(managedObjectContext: NSManagedObjectContext, noteToBeCreated: JournalModel) {

         let noteEntity = NSEntityDescription.entity(forEntityName: "Journal", in: managedObjectContext)!
         let newNoteToBeCreated = Journal(entity: noteEntity, insertInto: managedObjectContext)
         newNoteToBeCreated.journalId = noteToBeCreated.journalId
         newNoteToBeCreated.journalTitle = noteToBeCreated.journalTitle
         newNoteToBeCreated.journalDescription = noteToBeCreated.journalDescription
         newNoteToBeCreated.journalTimeStamp = noteToBeCreated.journalTimeStamp
         do {
             try managedObjectContext.save()
         } catch let error as NSError {
             print("Could not save. \(error), \(error.userInfo)")
         }
     }
    static func readNotesFromCoreData(managedObjectContext: NSManagedObjectContext) -> [JournalModel] {

         var returnedNotes = [JournalModel]()
         let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
         fetchRequest.predicate = nil
         do {
             let fetchedNotesFromCoreData = try managedObjectContext.fetch(fetchRequest)
             fetchedNotesFromCoreData.forEach { (fetchRequestResult) in
                 let noteManagedObjectRead = fetchRequestResult as? Journal
                 returnedNotes.append(JournalModel.init(
                                        journalId: noteManagedObjectRead!.journalId!,
                                        journalTitle: noteManagedObjectRead!.journalTitle!,
                                        journalText: noteManagedObjectRead!.journalDescription! ,
                                        journalTimeStamp: Int64(noteManagedObjectRead!.journalTimeStamp)))
             }
         } catch let error as NSError {
             print("Could not read. \(error), \(error.userInfo)")
         }
         return returnedNotes
     }
    static func readNoteFromCoreData(noteIdToBeRead: UUID,
                                     fromManagedObjectContext: NSManagedObjectContext) -> JournalModel? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
        let noteIdPredicate = NSPredicate(format: "journalId = %@", noteIdToBeRead as CVarArg)
        fetchRequest.predicate = noteIdPredicate
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
            guard let noteManagedObjectToBeRead = fetchedNotesFromCoreData[0] as? Journal else { return nil }
            return JournalModel(journalId: noteManagedObjectToBeRead.journalId!,
                                journalTitle: noteManagedObjectToBeRead.journalTitle!,
                                journalText: noteManagedObjectToBeRead.journalDescription!,
                             journalTimeStamp: noteManagedObjectToBeRead.journalTimeStamp)
        } catch let error as NSError {
            print("Could not read. \(error), \(error.userInfo)")
            return nil
        }
    }
    static func changeNoteInCoreData(noteToBeChanged: JournalModel,
                                     inManagedObjectContext: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
        let noteIdPredicate = NSPredicate(format: "journalId = %@", noteToBeChanged.journalId as CVarArg)
        fetchRequest.predicate = noteIdPredicate
        do {
            let fetchedNotesFromCoreData = try inManagedObjectContext.fetch(fetchRequest)
            let noteManagedObjectToBeChanged = fetchedNotesFromCoreData[0] as? Journal
            noteManagedObjectToBeChanged?.journalId = noteToBeChanged.journalId
            noteManagedObjectToBeChanged?.journalTitle = noteToBeChanged.journalTitle
            noteManagedObjectToBeChanged?.journalDescription = noteToBeChanged.journalDescription
            noteManagedObjectToBeChanged?.journalTimeStamp = noteToBeChanged.journalTimeStamp
            // save
            try inManagedObjectContext.save()

        } catch let error as NSError {
            print("Could not change. \(error), \(error.userInfo)")
        }
    }

    static func deleteJournalFromCoreData(journalIdToBeDeleted: UUID,
                                          fromManagedObjectContext: NSManagedObjectContext) {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Journal")
        let noteIdAsCVarArg: CVarArg = journalIdToBeDeleted as CVarArg
        let noteIdPredicate = NSPredicate(format: "journalId == %@", noteIdAsCVarArg)
        fetchRequest.predicate = noteIdPredicate
        do {
            let fetchedNotesFromCoreData = try fromManagedObjectContext.fetch(fetchRequest)
            let noteManagedObjectToBeDeleted = fetchedNotesFromCoreData[0] as? Journal
            fromManagedObjectContext.delete(noteManagedObjectToBeDeleted!)
            do {
                try fromManagedObjectContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}
