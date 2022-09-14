//
//  FindCityViewController.swift
//  NatifeTestProj
//
//  Created by Yaroslav Shepilov on 28.07.2022.
//

import UIKit
import MapKit

class FindCityViewController: UIViewController {

//    let mapView = MKMapView()
    let searchController = UISearchController(searchResultsController: SearchResultViewController())
    private var isFiltering = false
    var isSearchBarEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(mapView)
        searchController.searchBar.backgroundColor = .secondarySystemBackground
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.size.width, height: view.frame.size.height - view.safeAreaInsets.top)
    }
    
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let query = searchController.searchBar.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
//            return
//        }
//        GooglePlacesManager.shared.findPlaces(query: query) { result in
//            switch result {
//            case .success(let places):
//                print(places)
//            case  .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}

extension FindCityViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text)
    }
   
    func willPresentSearchController(_ searchController: UISearchController) {
        isFiltering = true
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        isFiltering = false
    }
    
    private func filterContentForSearchText(_ searchText: String?) {

    }
}

