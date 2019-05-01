//
//  ViewController.swift
//  Eindopdracht_MobileDev2_iOS
//
//  Created by Fam Hermsen on 01/05/2019.
//  Copyright © 2019 Kim. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = URL(string: "https://pokeapi.co/api/v2/pokemon") {
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let receivedData = data {
                    Swift.print("\(receivedData)")
                    
                    do {
                        // Optie 1: Gebruik JSONSerialization
                        
//                        if let json = try JSONSerialization.jsonObject(with: receivedData) as? [String:Any] {
//                            Swift.print("\(json)")
//
//                            var temperatureInKelvin : NSMeasurement?
//
//                            if let main = json["main"] as? [String:Any],
//                                let temperature = main["temp"] as? Double
//                            {
//                                temperatureInKelvin = NSMeasurement(doubleValue:  temperature, unit: UnitTemperature.kelvin)
//                            }
                        
                            // Optie 2: Gebruik Codable protocol
                            let decoder = JSONDecoder()
                            let pokemonData = try decoder.decode(PokemonData.self, from: receivedData)
                            
                            temperatureInKelvin = NSMeasurement(doubleValue: weatherData.main.temp, unit: UnitTemperature.kelvin)
                            
                            // convert temperature to celsius
                            if let temperatureInCelsius =  temperatureInKelvin?.converting(to: UnitTemperature.celsius).value {
                                
                                DispatchQueue.main.async {
                                    self.temperatureLabel.text = "\(temperatureInCelsius.round(toNumberOfDigits: 1))"
                                }
                            }
                        }
                    } catch { }
                }
            
            
            
            }
            
              task.resume()
        }

    }

    
    var series = ["Rick and morty", "House of cards", "Breaking bad"]
    
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

        }
    }

}
