
import RxSwift
import Foundation
import RealmSwift

class MainVCViewModel {
    
    
    var charToDisplay =  Variable<[People]>([])
    var hideInfoView = Variable<Bool>(true)
    var char = BehaviorSubject<People?>(value: nil)
    
    func getLastChar() {
        let realm = try! Realm()
        if let lastSavedChar = realm.objects(People.self).last {
            charToDisplay.value.removeAll()
            charToDisplay.value.append(lastSavedChar)
            print("last saved char : \(lastSavedChar)")
        }
    }
        func getLast() {
            let realm = try! Realm()
            if let lastSavedChar = realm.objects(People.self).last {
                print("Последний сохраненный: \(lastSavedChar.name)")
                char.onNext(lastSavedChar)
            }
    }
    
}
