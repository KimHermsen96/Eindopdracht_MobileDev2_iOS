//
//  FavoritesTableViewController.swift
//  Eindopdracht_MobileDev2_iOS
//
//  Created by Kim Hermsen on 05/06/2019.
//  Copyright © 2019 Kim. All rights reserved.
//

import UIKit
import CoreData
class FavoritesTableViewController: UITableViewController {
	
    override func viewDidLoad() {
        
        super.viewDidLoad()
        retrieveData()
    }
	
    public var favoriteList:[String] = []

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCel", for:indexPath)
        cell.textLabel?.text = favoriteList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        ->   UISwipeActionsConfiguration? {
            
            let delete = UIContextualAction(style: .normal, title: "Delete") { (action, view , nil) in
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let currentCell = tableView.cellForRow(at: indexPath )! as UITableViewCell
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePokemon")
                fetchRequest.predicate = NSPredicate(format: "name = %@", currentCell.textLabel!.text!)
                
                do{
                    let object = try managedContext.fetch(fetchRequest)
                    let objectToDelete = object[0] as! NSManagedObject
                    managedContext.delete(objectToDelete)
                    
                    do{
                        try managedContext.save()
                        
                        if let index = self.favoriteList.firstIndex(of: currentCell.textLabel!.text!) {
                            self.favoriteList.remove(at: index)
                        }
                        
                        self.tableView.reloadData();
                    }catch{
                        print(error)
                    }
                }catch{
                    print(error)
                }
                
                
            }
            return UISwipeActionsConfiguration (actions: [delete])
    }
    
    
    
    func retrieveData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritePokemon")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                favoriteList.append(data.value(forKey: "name") as! String)
            }
        }catch{
            print("Failed")
        }
    }
    func deleteData(){
        
        
    }


}
