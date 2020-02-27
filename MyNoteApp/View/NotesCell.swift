//
//  TVCNotes.swift
//  MyNoteApp
//
//  Created by Hady Hammad on 1/27/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var noteTextLbl: UITextView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureNote(note:Note){
        titleLbl.text=note.title
        noteTextLbl.text=note.details
        timeLbl.text = note.date_save!.calendarTimeSinceNow()
    }
}
