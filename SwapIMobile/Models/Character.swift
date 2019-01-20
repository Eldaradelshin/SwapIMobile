
import Foundation
import RealmSwift

class People: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var height: String = ""
    @objc dynamic var hair_color: String = ""
    @objc dynamic var skin_color: String = ""
    @objc dynamic var  eye_color: String = ""
    @objc dynamic var birth_year: String = ""
    @objc dynamic var gender: String = ""
    
    convenience init?(json: [String: Any]) {
        
        self.init()
        
        guard
        
        let name = json["name"] as? String,
        let height = json["height"] as? String,
        let hair_color = json["hair_color"] as? String,
        let skin_color = json["skin_color"] as? String,
        let eye_color = json["eye_color"] as? String,
        let birth_year = json["birth_year"] as? String,
        let gender = json["gender"] as? String
        
        else { return nil }
        
        self.name = name
        self.height = height
        self.hair_color = hair_color
        self.skin_color = skin_color
        self.eye_color = eye_color
        self.birth_year = birth_year
        self.gender = gender
    }
}
