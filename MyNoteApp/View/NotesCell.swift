//
//  TVCNotes.swift
//  MyNoteApp
//
//  Created by Hady Hammad on 1/27/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {
    
    @IBOutlet weak var laDate: UILabel!
    @IBOutlet weak var laText: UITextView!
    @IBOutlet weak var laTitle: UILabel!
    @IBOutlet weak var buDelete: UIButton!
    @IBOutlet weak var buEdit: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setNotes(note:Note){
        
        laTitle.text=note.title
        laText.text=note.details
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        //formatter.dateFormat = "mm/dd/yy h:mm a"
        let now = formatter.string(from: note.date_save! as Date)
        laDate.text = now
        
    }
}
