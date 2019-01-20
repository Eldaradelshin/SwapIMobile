
import UIKit
import RxSwift
import RxCocoa

class MainVC: UIViewController {

    let viewModel = MainVCViewModel()
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var matchesTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var CharacterInfoView: UIView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birthYear: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var hairColor: UILabel!
    @IBOutlet weak var skinColor: UILabel!
    @IBOutlet weak var eyeColor: UILabel!
    
    @IBAction func performSearchButton(_ sender: UIButton) {
        if let searchText = textField.text {
            viewModel.serchForPeople(search: searchText)
        } else { return }
        if viewModel.characters.value.count > 1 {
            statusLabel.isHidden = false
            statusLabel.text = "Уточните,кого вы искали?"
            matchesTableView.isHidden = false
        } else if  viewModel.characters.value.count == 1 {
            self.viewModel.sharToDisplaySetup()
            statusLabel.isHidden = false
            statusLabel.text = "Найдено 1 совпадение"
            CharacterInfoView.isHidden = false
            viewModel.saveObjectToHistory(viewModel.charToDisplay.value!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        tableBinding()
        infoBinding()
        rawTapped()
        //setInfoLabels()
    }
    
    func tableBinding() {
        viewModel.characters.asObservable().bind(to: matchesTableView.rx.items(cellIdentifier: "Cell")) {
            (row, element, cell) in
            cell.textLabel?.text = "\(element.name)"
            }.disposed(by: disposeBag)
        }
    func infoBinding() {
        viewModel.charToDisplay.asObservable().subscribe { charToDisplay in
            self.name.text = "Name: \(charToDisplay.element!?.name ?? "")"
            self.gender.text = "Gender: \(charToDisplay.element!?.gender ?? "")"
            self.birthYear.text = "Birth:\(charToDisplay.element!?.birth_year ?? "")"
            self.height.text = "Height: \(charToDisplay.element!?.height ?? "")"
            self.hairColor.text = "Hair:\(charToDisplay.element!?.hair_color ?? "")"
            self.skinColor.text = "Skin:  \(charToDisplay.element!?.skin_color ?? "")"
            self.eyeColor.text = "Eyes: \(charToDisplay.element!?.eye_color ?? "")"
        }.disposed(by: disposeBag)
    }
    
    func rawTapped() {
        matchesTableView.rx.modelSelected(People.self).subscribe({ model in
           self.viewModel.characters.value = [model.element!]
            self.viewModel.charToDisplay.value = self.viewModel.characters.value.first
            print(model.element!.name)
            self.matchesTableView.isHidden = true
            self.statusLabel.text = "Персонаж найден!"
            self.CharacterInfoView.isHidden = false
             self.viewModel.sharToDisplaySetup()
            self.viewModel.saveObjectToHistory(self.viewModel.charToDisplay.value!)
            
        }).disposed(by: disposeBag)
       
        
    }
    
    func setup() {
        self.viewModel.sharToDisplaySetup()
        statusLabel.isHidden = true
        matchesTableView.isHidden = true
        CharacterInfoView.isHidden = true
    }
   
}

