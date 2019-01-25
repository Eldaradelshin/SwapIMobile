
import Foundation
import Alamofire

final class RequestService {
    
    static let shared = RequestService()
    
    
   private init(){}
    
    let baseUrl: String = "https://swapi.co/api/"
    let peopleSearchPath: String = "people/"
    
    func searchCharacters(search: String, completion: @escaping ([People]) -> Void) {
        let fullPath = URL(string: baseUrl+peopleSearchPath)!
        request(fullPath, method: .get, parameters: ["search" : search]).responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
               guard let dict = value as? [String:Any] else { return }
               guard let jsonArray = dict["results"] as? [[String:Any]] else { return }
               var characters = [People]()
               for jsonObject in jsonArray {
                    let people = People(json: jsonObject)
                characters.append(people!)
                }
                //print(characters)
                completion(characters)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
