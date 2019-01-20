

import UIKit
import RxSwift
import RxCocoa

class HistoryView: UIViewController {

    @IBOutlet weak var historyTableView: UITableView!
    
    let viewModel = HistoryViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
