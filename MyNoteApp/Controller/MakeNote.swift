//
//  ViewController.swift
//  MyNoteApp
//
//  Created by Hady Hammad on 1/27/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit

class MakeNote: UIViewController {
    
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteText: UITextView!
    var editedNote:Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let note = editedNote{
            noteTitle.text = note.title
            noteText.text = note.details
        }
    }
    
    @IBAction func buSave(_ sender: Any) {
        
        var newNote:Note?
        
        if let note = editedNote{
            newNote=note
        }else{
            newNote = Note(context: context)
        }
        
        newNote?.title = noteTitle.text
        newNote?.details = noteText.text
        newNote?.date_save = NSDate() as Date
        
        ad.saveContext()
        noteTitle.text = ""
        noteText.text = ""  
    }
    @IBAction func buBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

