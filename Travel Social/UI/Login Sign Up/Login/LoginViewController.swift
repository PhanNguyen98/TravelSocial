//
//  LoginViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 20/01/2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

//MARK: Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
//MARK: View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setViewKeyboard()
        setNavigation()
        emailTextField.text = "c@c.com"
        passwordTextField.text = "C123456"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//MARK: SetUI
    func setNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func setUI() {
        self.view.setBackgroundImage(img: UIImage(named: "background")!)
        self.hideKeyboardWhenTappedAround()
        
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.masksToBounds = true
        passwordTextField.isSecureTextEntry = true
        
        logInButton.layer.cornerRadius = logInButton.frame.height / 2
        logInButton.layer.masksToBounds = true
        
        signUpButton.layer.cornerRadius = logInButton.frame.height / 2
        signUpButton.layer.masksToBounds = true
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
//MARK: SetKeyboard
    func setViewKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    
//MARK: IBAction
    @IBAction func logIn(_ sender: Any) {
        self.logInButton.isEnabled = false
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            self.logInButton.isEnabled = true
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.logInButton.isEnabled = true
                self.showError(message: error!.localizedDescription)
            } else {
                self.logInButton.isEnabled = true
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                DataManager.shared.getUserFromId(id: (result!.user.uid))
                let customBarViewController = CustomBarViewController()
                self.navigationController?.pushViewController(customBarViewController, animated: true)
            }
        }
    }
    
    @IBAction func showSignUp(_ sender: Any) {
        let signUpViewController = SignUpViewController()
        signUpViewController.modalPresentationStyle = .overFullScreen
        self.present(signUpViewController, animated: true, completion: nil)
    }

}
