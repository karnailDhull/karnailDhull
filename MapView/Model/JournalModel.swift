//
//  Notes.swift
//  MapView
//
//  Created by Karnail Singh on 13/02/22.
//

import Foundation

class JournalModel {

    private(set) var journalId: UUID
    private(set) var journalTitle: String
    private(set) var journalDescription: String
    private(set) var journalTimeStamp: Int64

    init(journalTitle: String, journalText: String, journalTimeStamp: Int64) {
        self.journalId        = UUID()
        self.journalTitle     = journalTitle
        self.journalDescription      = journalText
        self.journalTimeStamp = journalTimeStamp
    }

    init(journalId: UUID, journalTitle: String, journalText: String, journalTimeStamp: Int64) {
        self.journalId        = journalId
        self.journalTitle     = journalTitle
        self.journalDescription = journalText
        self.journalTimeStamp = journalTimeStamp
    }
}
