
import Foundation

struct AllPokemon : Codable {
    var results : [results]
}

struct results : Codable{
    var name : String?
    var url : String?
}

    
struct pokemonDetail : Codable {
    var abilities : [ability]?
    var base_experience : Int?
    var height : Int?
    var moves: [Moves]?
    var weight : Int?
    var sprites : sprites?
}


struct sprites : Codable{
    var front_default: String?
}
struct ability : Codable {
    var name: String?
}

struct Moves : Codable {
    var move : String?
}
