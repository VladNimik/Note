//
//  NoteViewController.swift
//  Notes
//
//  Created by nimik on 05/08/2018.
//  Copyright © 2018 nimik. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    var noteId = Int()
    var lastId = Int()
    var itemsCount = [NoteModel]()
    var item: NoteModel?
    var fromAllNotes = false
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveBtn.title = "saveBtn".localized
        navigationItem.largeTitleDisplayMode = .never
        self.view.backgroundColor = UIColor.white
        
       
      
        NetworkLayer.shared.getAllNotes { (item, error)  in
            if let count = item {
                for i in 0 ..< count.count{
                    self.lastId = count[i].id
                }
            }
        }

        if fromAllNotes{
            NetworkLayer.shared.getNote(id: noteId) { (note) in
                self.textView.text = note?.title
            }
        }
        else{

            textView.becomeFirstResponder()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneBtnAction(_ sender: UIBarButtonItem) {
        if fromAllNotes == false{
            NetworkLayer.shared.postNote(note: NoteModel(id: lastId + 1, title: textView.text)) { (noteResponse, error)  in
                self.textView.text = noteResponse?.title
                self.textView.resignFirstResponder()
            }
        }
        else if fromAllNotes == true{
            NetworkLayer.shared.putNote(note: NoteModel(id: noteId, title: textView.text), completion: { (noteResponse, error)  in
                self.textView.text = noteResponse?.title
                self.textView.resignFirstResponder()
                print(noteResponse?.title ?? "")
            })
        }
    }
}
