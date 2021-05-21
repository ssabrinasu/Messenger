//
//  ViewController.swift
//  Messenger
//
//  Created by Tabata Sabrina Sutili on 05/05/21.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    private func validateAuth(){
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vcLogin = LoginViewController()
            let nav = UINavigationController(rootViewController: vcLogin)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}
