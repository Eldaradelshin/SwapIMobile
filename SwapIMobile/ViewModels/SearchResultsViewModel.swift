
import Foundation
import RxSwift
import RealmSwift

class SearchResultsViewModel {
    
    
    var characters = Variable<[People]>([])
    var charToDisplay =  Variable<People?>(nil)
    
    func serchForPeople(search: String) {
        RequestService.shared.searchCharacters(search: search, completion: { [weak self] recievedChars in
            self?.characters.value = recievedChars
            // print(self.characters.value.count)
        })
    }
    
    
    func saveObjectToHistory(_ personToSave: People) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(personToSave)
        }
        print("\(personToSave.name) saved!")
    }
    
    
}
