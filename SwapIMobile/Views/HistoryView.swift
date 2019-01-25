

import UIKit
import RxSwift
import RxCocoa
import RxRealm
import RealmSwift

class HistoryView: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    let viewModel = HistoryViewModel()
    let disposeBag = DisposeBag()
    
    @IBAction func clearAction(_ sender: UIButton) {
        self.viewModel.clearHistory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getSavedCharacters()
        tableBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewModel.getSavedCharacters()
    }
    
    func tableBinding() {
        viewModel.savedCharacters.asObservable().bind(to:
        historyTableView.rx.items(cellIdentifier: "historyCell")) {
            (row, element, cell) in
            cell.textLabel?.text = "\(element.name)"
        }.disposed(by: disposeBag)
    }
}
