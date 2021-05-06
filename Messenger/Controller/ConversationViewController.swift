//
//  ViewController.swift
//  Messenger
//
//  Created by Tabata Sabrina Sutili on 05/05/21.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Se o userDefault de login estiver vazio entao é chamada a tela de login
        let isLonggedIn = UserDefaults.standard.bool(forKey: "longged_in")
        if !isLonggedIn {
            let vcLogin = LoginViewController()
            let nav = UINavigationController(rootViewController: vcLogin)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}
