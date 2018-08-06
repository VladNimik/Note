//
//  ViewController.swift
//  Notes
//
//  Created by nimik on 05/08/2018.
//  Copyright © 2018 nimik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var addNoteBtn: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    var fromAllNotes = Bool()
    var note = [NoteModel]()
    var searchContent = [NoteModel]()
    var search = UISearchController(searchResultsController: nil)
    

    
    @IBAction func addNoteBtnAction(_ sender: UIBarButtonItem) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    @IBAction func changeLanguageAction(_ sender: UIBarButtonItem) {
        
        let menu = UIAlertController(title: "changeLangTitle".localized, message: nil, preferredStyle: .actionSheet)
        
        func addActionLanguage(language: Language) {
            menu.addAction(
                UIAlertAction(title: language.rawValue.localized, style: UIAlertActionStyle.default, handler: { _ in
                        Language.language = language
                })
            )
        }
        addActionLanguage(language: Language.english)
        addActionLanguage(language: Language.russian)
        addActionLanguage(language: Language.czech)
        
        menu.addAction(UIAlertAction(title: "cancelAlert".localized, style: .cancel, handler: nil))
        present(menu, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor(red:0.00, green:0.65, blue:0.42, alpha:1.0) // fixing black artifact
        
        search.searchBar.tintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "search".localized, attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        
        search.searchBar.setImage(UIImage(named: "icons8-search-16"), for: .search, state: .normal)
        search.searchBar.setImage(UIImage(named: "icons8-no-16"), for: .clear, state: .normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadNotes()
        
       
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.white
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
       
        
        title = "notesTitle".localized
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        search.searchResultsUpdater = self
        search.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = search
        search.searchBar.setValue("cancelAlert".localized, forKey: "cancelButtonText")
        
       
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    @objc func refreshTable(refreshControl: UIRefreshControl){
        downloadNotes()
        refreshControl.endRefreshing()
    }

    func downloadNotes(){
        NetworkLayer.shared.getAllNotes { (item, error) in
            self.note = item!
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if search.isActive{
            return searchContent.count
        }
        else{
            return note.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let noteItem = (search.isActive) ? searchContent[indexPath.row] : note[indexPath.row]
        cell.textLabel?.text = noteItem.title
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = (search.isActive) ? searchContent[indexPath.row] : self.note[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NoteViewController") as! NoteViewController
        vc.noteId = note.id
        vc.fromAllNotes = true
        navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {


        let share = UITableViewRowAction(style: .destructive, title: "shareAction".localized) { (action, indexPath) in
            let textForCopy = self.note[indexPath.row].title
            let activityController = UIActivityViewController(activityItems: [textForCopy], applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = self.view
            self.present(activityController, animated: true, completion: nil)
        }
        share.backgroundColor = UIColor(red:0.79, green:0.79, blue:0.79, alpha:1.0)
        
        let delete = UITableViewRowAction(style: .destructive, title: "deleteAction".localized) { (action, indexPath) in
            NetworkLayer.shared.deletePost(id: self.note[indexPath.row].id) { (note) in
                print(note?.title ?? "")
            }
            self.note.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
        }
        
        delete.backgroundColor = UIColor.red
        
        return [delete, share]
    }
}


extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text{
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText:String){
        searchContent = note.filter({ (note: NoteModel) -> Bool in
            let nameFilter = note.title.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            return nameFilter != nil
        })
        
    }



}


