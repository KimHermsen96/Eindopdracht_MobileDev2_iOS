
import Foundation

struct AllPokemon : Codable {
    var results : [results]
}

struct results : Codable{
    var name : String?
    var url : String?
}

    
struct pokemonDetail : Codable {
    var abilities : [ability]
    var base_experience : String?
    var height : String?
    var moves: [Moves]?
    var weight : String?
}

struct ability : Codable {
    var name: String?
}

struct Moves : Codable {
    var move : String?
}
