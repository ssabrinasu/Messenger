//
//  AppDelegate.swift
//  Messenger
//
//  Created by Tabata Sabrina Sutili on 05/05/21.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    
    
    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application,
                                               didFinishLaunchingWithOptions: launchOptions )
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance()?.delegate = self
        return true
    }
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        ApplicationDelegate.shared.application(app,
                                               open: url,
                                               sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                               annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
       
        if let error = error {
            print("Failed to sing in with Google: \(error) ")
        }
        
        guard let email = user.profile.email,
           let name = user.profile.givenName,
           let lastName = user.profile.familyName else {return}
        
            DatabaseManager.shared.userExists(with: email, completion: { exist in
                if !exist {
                    DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: name, lastName: lastName, emailAddress: email))
                }
                
            })
        
        
        
        guard let authentication = user.authentication else {
            print("Missing auth object off of google user")
            return}
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        FirebaseAuth.Auth.auth().signIn(with: credential, completion: { authResult, error in
            guard authResult != nil, error == nil else {
                print("Failed to log winth google credential")
                return
            }
            print("successfully singned in with google cred.")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "didLogInNotification"), object: nil)
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //
    }
    
    
    
    

}
