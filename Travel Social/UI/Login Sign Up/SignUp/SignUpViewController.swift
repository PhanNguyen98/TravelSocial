//
//  SignUpViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 20/01/2021.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

//MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
//MARK: View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setViewKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
//MARK: SetUI
    func setUI() {
        self.view.setBackgroundImage(img: UIImage(named: "background")!)
        self.hideKeyboardWhenTappedAround()
        
        nameTextField.layer.cornerRadius = 20
        nameTextField.layer.masksToBounds = true
        
        emailTextField.layer.cornerRadius = 20
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = 20
        passwordTextField.layer.masksToBounds = true
        passwordTextField.isSecureTextEntry = true
        
        signUpButton.layer.cornerRadius = signUpButton.frame.height / 2
        signUpButton.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = signUpButton.frame.height / 2
        loginButton.layer.masksToBounds = true
    }
    
    func validateFields() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "please fill in all fields"
        }
        
        guard let cleanPassword = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
              else { return "please fill in all fields" }
        
        if Utilities.isValidPassword(cleanPassword) == false {
            return "please make sure your password least 8 characters, capital, number"
        }
        
        if Utilities.isValidEmail(email: email) == false {
            return "please retype email"
        }
        
        return nil
    }
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
//MARK: IBAction
    @IBAction func showLoginView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        self.signUpButton.isEnabled = false
        let error = validateFields()
        if error != nil {
            self.signUpButton.isEnabled = true
            showError(message: error!)
        } else {
            let fullName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.signUpButton.isEnabled = true
                    self.showError(message: "Error Creating User")
                } else {
                    self.signUpButton.isEnabled = true
                    self.nameTextField.text = ""
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    DataManager.shared.user.name = fullName
                    DataManager.shared.user.id = result!.user.uid
                    DataManager.shared.setDataUser()
                    let customBarViewController = CustomBarViewController()
                    self.navigationController?.pushViewController(customBarViewController, animated: true)
                }
                
            }
        }
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
    
}
