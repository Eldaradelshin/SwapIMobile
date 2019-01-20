
import RxSwift
import Foundation
import RealmSwift

class MainVCViewModel {
    
    let requestService = RequestService()
    
    var characters = Variable<[People]>([])
    var charToDisplay =  Variable<People?>(nil)
    
    
    func serchForPeople(search: String) {
        requestService.searchCharacters(search: search, completion: { recievedChars in
            self.characters.value = recievedChars
            print(self.characters.value.count)
        })
    }
    
    func sharToDisplaySetup() {
         if characters.value.count == 1 {
            charToDisplay.value = characters.value.first
        }
        
    }
    
    func saveObjectToHistory(_ personToSave: People) {
        
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(personToSave)
        }
        print("\(personToSave.name) saved!")
    }
    
}
