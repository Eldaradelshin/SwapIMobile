

import Foundation
import UIKit

extension SearchResultsView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchBarText = searchController.searchBar.text else { return }
        self.viewModel.serchForPeople(search: searchBarText)
    }
    
    
}
