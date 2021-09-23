//
//  ProfileViewController.swift
//  Messenger
//
//  Created by Tabata Sabrina Sutili on 05/05/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableViewProfile: UITableView!
    let data = ["Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewProfile.register(UITableViewCell.self,
                                  forCellReuseIdentifier: "cell")
        tableViewProfile.delegate = self
        tableViewProfile.dataSource = self
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewProfile.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.textColor = .red
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewProfile.deselectRow(at: indexPath, animated: true)
        let actionSheet = UIAlertController(title: "",
                                            message: "",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log out",
                                            style: .destructive,
                                            handler: { [weak self]_ in
                                            guard let strongSelf = self else {
                                                    return
                                                }
                                            do {
                                               try FirebaseAuth.Auth.auth().signOut()
                                                let vcLogin = LoginViewController()
                                                let nav = UINavigationController(rootViewController: vcLogin)
                                                nav.modalPresentationStyle = .fullScreen
                                                strongSelf.present(nav, animated: true)
                                            } catch {
                                                print("Filed to log out")
                                            }
                                            }))
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        present(actionSheet, animated: true)
    }
}
