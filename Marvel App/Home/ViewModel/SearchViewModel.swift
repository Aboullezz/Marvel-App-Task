//
//  SearchViewModel.swift
//  Marvel App
//
//  Created by Mohamed Aboullezz on 25/09/2023.
//

import UIKit

extension HomeViewController: UISearchBarDelegate{
   
    
//    dismiss the keyboard
    func performEndingSearch(){
        view.endEditing(true)
    }
//    setup keyboardToolBar
    func keyboardToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let placeholderLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        placeholderLabel.text = "Search ..."
        placeholderLabel.textColor = .gray
        placeholderLabel.textAlignment = .center
        
        let placeholderBarButton = UIBarButtonItem(customView: placeholderLabel)
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let doneButton = UIButton(type: .custom)
        doneButton.setTitle("Dismiss", for: .normal)
        doneButton.setTitleColor(.gray, for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        let doneBarButton = UIBarButtonItem(customView: doneButton)
        toolbar.items = [placeholderBarButton, flexBarButton, doneBarButton]
        searchBar.searchTextField.inputAccessoryView = toolbar
        searchBar.returnKeyType = .search
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        doneButton.translatesAutoresizingMaskIntoConstraints = false
    }
    @objc func doneButtonTapped() {
        searchBar.resignFirstResponder()
    }
//    when typing it search data immediatly
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            homeViewModel.filterData(with: searchText)
        }
}
