//
//  VCListNotes.swift
//  MyNoteApp
//
//  Created by Hady Hammad on 1/27/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit
import CoreData
class DisplayNotesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var listOfNotes=[Note]()
    
    @IBOutlet weak var notesTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadNotes()
        
        notesTable.delegate=self
        notesTable.dataSource=self
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! NotesCell
        cell.setNotes(note: listOfNotes[indexPath.row])
        
        cell.buDelete.tag=indexPath.row
        cell.buDelete.addTarget(self, action: #selector(buDeletePress(_:)), for: .touchUpInside)
        
        cell.buEdit.tag=indexPath.row
        cell.buEdit.addTarget(self, action: #selector(buEditPress(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    @objc func buDeletePress(_ sender:UIButton){
        print("index\(sender.tag)")
        context.delete(listOfNotes[sender.tag])
        ad.saveContext()
        loadNotes()
    }
    
    @objc func buEditPress(_ sender:UIButton){
        performSegue(withIdentifier: "EditOrAddSegway", sender: listOfNotes[sender.tag]) 
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditOrAddSegway"{
            if let EditOrAdd = segue.destination as? MakeNote{
                if let myNote = sender as? Note{
                    EditOrAdd.editedNote = myNote
                }
            }
        }
    }
    
    @IBAction func buAdd(_ sender: Any) {
        performSegue(withIdentifier: "EditOrAddSegway", sender: nil)
    }
    
    func loadNotes(){
        let fetchedData:NSFetchRequest<Note> = Note.fetchRequest()
        do{
            listOfNotes = try context.fetch(fetchedData)
            notesTable.reloadData()
        }catch{
            print("can't load the data from database")
        }
        
    }
}
