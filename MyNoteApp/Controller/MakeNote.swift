//
//  ViewController.swift
//  MyNoteApp
//
//  Created by Hady Hammad on 1/27/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit

class MakeNote: UIViewController {
    
    // MARK :- Instance
    static func instance () -> MakeNote{
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "MakeNote") as! MakeNote
    }
    
    // MARK :- Outlets
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var noteTxtView: UITextView!
    @IBOutlet weak var noteImage: UIImageView!
    
    // MARK :- Instance Variables
    var editedNote : Note?
    
    // MARK :- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTxtView.textColor = .lightGray
        noteTxtView.delegate = self
        if let note = editedNote{
            titleTxtField.text = note.title
            noteTxtView.text = note.details
        }
    }
    
    @IBAction func buSave(_ sender: Any) {
        if titleTxtField.text!.isEmpty{
            AlertView.instance.showAlert(title: "Failure", message: "Please Enter The Title", alertType: .failure)
            return
        }
        if noteTxtView.text!.isEmpty{
            AlertView.instance.showAlert(title: "Failure", message: "Please Enter The Note Text", alertType: .failure)
            return
        }
        var newNote:Note?
        if let note = editedNote{
            newNote=note
        }else{
            newNote = Note(context: context)
        }
        newNote?.title = titleTxtField.text
        newNote?.details = noteTxtView.text
        newNote?.date_save = NSDate() as Date
        ad.saveContext()
        titleTxtField.text = ""
        noteTxtView.text = ""
        AlertView.instance.showAlert(title: "Success", message: "Note Added Successufully", alertType: .success)
    }
}

extension MakeNote: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter note text..."
            textView.textColor = .lightGray
        }
    }
}
