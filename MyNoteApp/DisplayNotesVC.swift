//
//  VCListNotes.swift
//  MyNoteApp
//
//  Created by Hady Hammad on 1/27/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit
import CoreData
class DisplayNotesVC: UIViewController{
    
    // MARK :- Outlets
    @IBOutlet weak var notesTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK :- Instance Variables
    var listOfNotes = [Note]()
    var currentNotesArray = [Note]()
    
    // MARK :- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.delegate=self
        notesTable.dataSource=self
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadNotes()
    }
    
    func loadNotes(){
        let fetchedData:NSFetchRequest<Note> = Note.fetchRequest()
        do{
            listOfNotes = try context.fetch(fetchedData)
            currentNotesArray = listOfNotes
            notesTable.reloadData()
        }catch{
            print("can't load the data from database")
        }
    }
    
}

extension DisplayNotesVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else{
            currentNotesArray = listOfNotes
            notesTable.reloadData()
            return
        }
        currentNotesArray = listOfNotes.filter({ note -> Bool in
            note.title!.lowercased().contains(searchText.lowercased())
        })
        notesTable.reloadData()
    }
}

extension DisplayNotesVC: UITableViewDelegate, UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentNotesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesCell
        cell.configureNote(note: currentNotesArray[indexPath.row])
        cell.deleteBtn.tag=indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(buDeletePress(_:)), for: .touchUpInside)
        cell.editBtn.tag=indexPath.row
        cell.editBtn.addTarget(self, action: #selector(buEditPress(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    @objc func buDeletePress(_ sender:UIButton){
        context.delete(currentNotesArray[sender.tag])
        ad.saveContext()
        loadNotes()
    }
    
    @objc func buEditPress(_ sender:UIButton){
        let makeNoteVC = MakeNote.instance()
        makeNoteVC.editedNote = currentNotesArray[sender.tag]
        self.navigationController?.pushViewController(makeNoteVC, animated: true)
    }
    
    @IBAction func buWriteNote(_ sender: Any) {
        self.navigationController?.pushViewController(MakeNote.instance(), animated: true)
    }
}
