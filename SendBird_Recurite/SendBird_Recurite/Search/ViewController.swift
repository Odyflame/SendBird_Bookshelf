//
//  ViewController.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
    }

}

extension ViewController: UISearchControllerDelegate {
    
}
