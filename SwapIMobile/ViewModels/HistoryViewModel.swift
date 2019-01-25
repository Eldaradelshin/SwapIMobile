
import Foundation
import RxSwift
import RealmSwift

class HistoryViewModel {
    
    var savedCharacters = Variable<[People]>([])
   
    
    func getSavedCharacters() {
         let realm = try! Realm()
        let savedChars = realm.objects(People.self).toArray()
        print("всего сохранено: \(savedChars.count)")
        savedCharacters.value = savedChars
    }
    
    func clearHistory() {
         let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
            print("История очищена.")
        savedCharacters.value = []
        
    }
    
}
