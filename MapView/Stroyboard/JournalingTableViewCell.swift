//
//  NoteTableViewCell.swift
//  MapView
//
//  Created by Karnail Singh on 13/02/22.
//

import UIKit

class JournalingTableViewCell: UITableViewCell {

    private(set) var journalTitle: String = ""
    private(set) var journalText: String = ""
    private(set) var journalDate: String = ""

    @IBOutlet weak var journalTitleLabel: UILabel!
    @IBOutlet weak var journalTextLabel: UILabel!
    @IBOutlet weak var journalDateLabel: UILabel!
}
