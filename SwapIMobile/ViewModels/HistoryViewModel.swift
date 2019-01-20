
import Foundation
import RxSwift
import RealmSwift

class HistoryViewModel {
    
    var savedCharacters = Variable<[People]>([])
    
    func getSavedCharacters() {
        let realm = try! Realm()
        let savedChars = realm.objects(People.self).toArray(ofType: People.self) as [People]
        print("всего сохранено: \(savedChars.count)")
        self.savedCharacters.value = savedChars
    }
    
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
