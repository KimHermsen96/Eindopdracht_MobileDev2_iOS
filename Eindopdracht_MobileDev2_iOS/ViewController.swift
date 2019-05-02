//
//  ViewController.swift
//  Eindopdracht_MobileDev2_iOS
//
//  Created by Fam Hermsen on 01/05/2019.
//  Copyright © 2019 Kim. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var series = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let receivedData = data {
                    Swift.print("hier \(receivedData)")
                    
                    do {
                        
                        let pokemonData = try JSONDecoder().decode(AllPokemon.self, from: receivedData)
                        
                        print(pokemonData.results)
                        
                        pokemonData.results.forEach { d in
                            let name = String(d.name ?? "")
                            self.series.append(name)
                            
                        }
                        
                        self.tableView.reloadData();
                    } catch { }
                    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let details = segue.destination as? DetailController {
            
            let indexPath = tableView.indexPathForSelectedRow!
            let currentCell = tableView.cellForRow(at: indexPath )! as UITableViewCell
            details.pokemonname = (currentCell.textLabel!.text ?? "def")
            
        }
    }
    
}
