
import UIKit
import RxSwift

class SearchResultsView: UIViewController {

    let viewModel = SearchResultsViewModel()
    let disposeBag = DisposeBag()
    var handleInfoUIDelegate: HandleInfoUI? = nil
    
    @IBOutlet weak var searchResultsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableBinding()
        rawTapped()
    }
    
    
    func tableBinding() {
        viewModel.characters.asObservable().bind(to: searchResultsTable.rx.items(cellIdentifier: "searchCell")) {
            (row, element, cell) in
            cell.textLabel?.text = "\(element.name)"
            }.disposed(by: disposeBag)
    }
    
    func rawTapped() {
        searchResultsTable.rx.modelSelected(People.self).subscribe({ model in
            self.viewModel.characters.value = [model.element!]
            self.viewModel.charToDisplay.value = self.viewModel.characters.value.first
            self.viewModel.saveObjectToHistory(model.element!)
            if self.handleInfoUIDelegate != nil {
                self.handleInfoUIDelegate?.updateInfoUI(charToDisplay: model.element!)
            }
            self.dismiss(animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
}
