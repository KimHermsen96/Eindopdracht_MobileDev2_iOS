//
//  ViewController.swift
//  Eindopdracht_MobileDev2_iOS
//
//  Created by Fam Hermsen on 01/05/2019.
//  Copyright © 2019 Kim. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    private var series = [String]()
    private var locationPokemon = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData();
    }
    
    func loadData(){
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let receivedData = data {
                    Swift.print("hier \(receivedData)")
                    var pokemonDataOptional: AllPokemon?
                    
                    do {
                        
                        pokemonDataOptional = try JSONDecoder().decode(AllPokemon.self, from: receivedData)
                        
                    } catch {
                        print("parsing failed")
                    }
                    
                    if let pokemonData = pokemonDataOptional {
                        DispatchQueue.main.async {
                            pokemonData.results.forEach { d in
                                let name = String(d.name)
                                self.series.append(name)
                                self.tableView.reloadData();
                            }
                        }
                    }
                    
                }
                
            }
            
            task.resume()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return series.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCel", for:indexPath)
        cell.textLabel?.text = series[indexPath.row]
        return cell
    }
    

    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        ->   UISwipeActionsConfiguration? {
            
            let add = UIContextualAction(style: .normal, title: "Add") { (action, view , nil) in
                //Container is stored in the appdelegate
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
                //create context for the container
                let managedContext = appDelegate.persistentContainer.viewContext
                //Create entity for new objects
                let favoriteEntity = NSEntityDescription.entity(forEntityName: "FavoritePokemon", in: managedContext)
                //Get the swiped row
                let currentCell = tableView.cellForRow(at: indexPath )! as UITableViewCell
            
                //Create object for saving value
                let object = NSManagedObject(entity: favoriteEntity!, insertInto: managedContext)
                  
                object.setValue(currentCell.textLabel!.text, forKey: "name")
                
                do{
                    try managedContext.save()
                    
                }catch let error as NSError {
                    print("Could not save. \(error), \(error.userInfo)")
                }
             
        
            }
            return UISwipeActionsConfiguration (actions: [add])
    }
    

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if destination is detailcontroller set pokemon name in controller
        if let details = segue.destination as? DetailController {
            
            let indexPath = tableView.indexPathForSelectedRow!
            let currentCell = tableView.cellForRow(at: indexPath )! as UITableViewCell
            details.pokemonname = (currentCell.textLabel!.text ?? "def")
            
        }
        
    }
    
}
