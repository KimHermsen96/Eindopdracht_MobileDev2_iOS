
import Foundation

struct AllPokemon : Codable {
    var results : [results]
}

struct results : Codable{
    var name : String
    var url : String
}

struct pokemonDetail : Codable {
    var abilities : [abilityObj]?
    var base_experience : Int?
    var height : Int?
    var weight : Int?
    var sprites : sprites?
}


struct sprites : Codable{
    var front_default: String?
}
struct abilityObj : Codable {
    var ability: ability
}

struct ability: Codable {
    var name: String
}
