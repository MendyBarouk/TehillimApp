//
//  MyChaptersTableViewController.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 14/05/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import CoreData

class MyChaptersTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, MyAlertViewControllerDelegate {
    
    var controller: NSFetchedResultsController<TehilimCore>
    
    required init?(coder aDecoder: NSCoder) {
        controller = TehilimCore.coreFethedResultsController()
        super.init(coder: aDecoder)
    }
    
    
    //My Function
    func showMyAlert() {
        self.performSegue(withIdentifier: "addSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue" {
            let nextVC = segue.destination as! MyAlertViewController
            nextVC.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showMyAlert))
        navigationItem.rightBarButtonItems = [addButton,self.editButtonItem]
        
        controller.delegate = self
    }

    
    // MARK: - MyAlertViewControllerDelegate
    func saveAlertAction(sender: UIButton, date: Date?, perek: String?, name: String?) {
        insertNewObject(date: date, perek: perek, name: name)
    }
    
    // MARK: - CoreData
    func insertNewObject(date: Date?, perek: String?, name: String?) {
        if let perek = perek {
            LocalDBManager.manager.createCore(with: date, name: name, perek: Int16(perek), priority: Int64(tableView.numberOfRows(inSection: 0)))
        }
        else {
            LocalDBManager.manager.createCore(with: date, name: name, perek: nil, priority: Int64(tableView.numberOfRows(inSection: 0)))
        }
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            debugPrint(newIndexPath!.row)
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            debugPrint(indexPath!.row)
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            let cell = tableView.cellForRow(at: indexPath!) as! MyChaptersCell
            cell.configure(withTehilimCore: anObject as! TehilimCore)
        case .move:
            let cell = tableView.cellForRow(at: indexPath!) as! MyChaptersCell
            cell.configure(withTehilimCore: anObject as! TehilimCore)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // MARK: - Table View
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return controller.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = controller.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyChaptersCell
        
        let tehilimCore = controller.object(at: indexPath)
        cell.configure(withTehilimCore: tehilimCore)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        controller.object(at: indexPath).removeFromDB()
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath == destinationIndexPath {
            return
        }
        
        controller.delegate = nil
        controller.object(at: sourceIndexPath).moveFromDB(sourceIndexPath: sourceIndexPath, destinationIndexPath: destinationIndexPath)
        controller.delegate = self
        
    }
}
