//
//  DetailController.swift
//  Eindopdracht_MobileDev2_iOS
//
//  Created by Fam Hermsen on 01/05/2019.
//  Copyright © 2019 Kim. All rights reserved.
//

import UIKit

class DetailController:  UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        nameLabel.text = pokemonname
        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonname)") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, err in
                DispatchQueue.main.async {
                    
                    

                    if let err  = err {
                        print("failed to get data from url:" ,err)
                        return
                    }
                    
                    if let receivedData = data{
                        
                        do{
                        
                            let pokemonData = try JSONDecoder().decode(pokemonDetail.self, from: receivedData)
 
                            if let sprite = pokemonData.sprites?.front_default{
                                
                                let url = URL(string: sprite)
                                let data = try Data(contentsOf: url!)
                                
                                let i = UIImage(data: data)
                            
//                                self.image.image = i;
                                if let loadedImage = i {
                                    
                                    self.pokemonImage.image = loadedImage
                                }
                            }
                    
                            if let height = pokemonData.height{
                                self.heightLabel.text = String(height)
                            }
                            
                            if let weight = pokemonData.weight{
                                self.weightLabel.text = String(weight)
                            }
                            
                            if let base_experience = pokemonData.base_experience{
                                self.experienceLabel.text = String(base_experience)
                            }
                            
                            
                            
                            
                        }catch{
                            
                        }
                    }
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

    
    @IBOutlet weak var pokemonImage: UIImageView!
}
