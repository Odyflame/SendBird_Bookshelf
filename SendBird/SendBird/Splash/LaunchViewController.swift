//
//  LaunchViewController.swift
//  SendBird_Recurite
//
//  Created by apple on 2021/03/21.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let viewController = SearchViewController()
        
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else {
          return
        }
        let navigationController = UINavigationController(rootViewController: viewController)

        window.rootViewController = navigationController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
