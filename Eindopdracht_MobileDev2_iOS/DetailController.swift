//
//  DetailController.swift
//  Eindopdracht_MobileDev2_iOS
//
//  Created by Fam Hermsen on 01/05/2019.
//  Copyright © 2019 Kim. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameLabel.text = pokemonname
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonname)") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let receivedData = data {
                    Swift.print("deze shit\(receivedData)")
                    
                    do {
                        
                        let pokemonData = try JSONDecoder().decode(pokemonDetail.self, from: receivedData)
                        
//                        print(pokemonData.abilities)
//
//                        pokemonData.results.forEach { d in
//                            let name = String(d.name ?? "")
//                            self.series.append(name)
                        
                        
//                        pokemonData.abilities.forEach({ ab in
//                           self.abilitiesLabel.text = ab.name
//                        })
                        
                        print(pokemonData.height)
                        
//                        self.heightLabel.text = pokemonData.height
//                        self.weightLabel.text = pokemonData.weight
                        
//                        self.abilitiesLabel.reloadInputViews()
//                        self.heightLabel.reloadInputViews()
//                        self.weightLabel.reloadInputViews()
//
                    
                    } catch { }
                    
                }
            }
            
            task.resume()
        }
        
        
        
        
    }
    
    @IBOutlet weak var experienceLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var attackLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    var pokemonname: String = " "
    
    
    
}
