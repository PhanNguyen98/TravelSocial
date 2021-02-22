//
//  HomeViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 20/01/2021.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setNavigation()
        self.view.setBackgroundImage(img: UIImage(named: "background")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @IBAction func logIn(_ sender: Any) {
        let loginViewController = LoginViewController()
        self.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func signUp(_ sender: Any) {
        let signUpViewCotroller = SignUpViewController()
        self.navigationController?.pushViewController(signUpViewCotroller, animated: true)
    }
    
    func setUI() {
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        logInButton.layer.masksToBounds = true
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor.black.cgColor
        signUpButton.layer.masksToBounds = true
    }

}
