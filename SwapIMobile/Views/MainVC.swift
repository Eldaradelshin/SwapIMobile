
import UIKit
import RxSwift
import RxCocoa

class MainVC: UIViewController, HandleInfoUI {

    let viewModel = MainVCViewModel()
    let disposeBag = DisposeBag()
    
    var resultSearchController:UISearchController? = nil
    
    @IBOutlet weak var CharacterInfoView: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    @IBOutlet weak var skinColor: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    
    
    @IBAction func clearInfoButton(_ sender: UIButton) {
        self.CharacterInfoView.isHidden = true
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchControllerSetup()
        self.viewModel.getLast()
        infoBinding()
         self.CharacterInfoView.isHidden = true
        
    }
        
    func infoBinding() {
        viewModel.char.subscribe { newChar in
            print(newChar.element??.name ?? "nothingHappened")
            if let ChangedChar  = newChar.event.element {
                if let charToDisplay = ChangedChar {
                    self.updateInfoUI(charToDisplay: charToDisplay)
                } else { print("Current char is nil") }
            } else { print("Value is not changed")}
        }.disposed(by: disposeBag)
    }
   
    
    func updateInfoUI(charToDisplay: People) {
        
        if self.CharacterInfoView.isHidden == true {
            self.CharacterInfoView.isHidden = false
        }
        
        self.name.text = "Имя: \(charToDisplay.name)"
        self.gender.text = "Пол: \(charToDisplay.gender)"
        self.birthYear.text = "Г.рождения: \(charToDisplay.birth_year)"
        self.height.text = "Рост \(charToDisplay.height)"
        self.hairColor.text = "Цвет волос: \(charToDisplay.hair_color)"
        self.skinColor.text = "Цвет кожи: \(charToDisplay.skin_color)"
        self.eyeColor.text = "Цвет глаз: \(charToDisplay.eye_color)"
    
    }
}

