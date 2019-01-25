
import Foundation
import UIKit

extension MainVC {
    
    func searchControllerSetup() {
    
        let searchResultsView = storyboard!.instantiateViewController(withIdentifier: "SearchResultsView") as! SearchResultsView
        resultSearchController = UISearchController(searchResultsController: searchResultsView)
        resultSearchController?.searchResultsUpdater = searchResultsView
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Введите имя персонажа."
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        searchResultsView.handleInfoUIDelegate = self
    }
    
}

protocol HandleInfoUI {
     func updateInfoUI(charToDisplay: People)
}
