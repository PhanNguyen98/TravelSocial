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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(popViewController))
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUI() {
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.borderWidth = 0.5
        nameTextField.layer.masksToBounds = true
        
        emailTextField.layer.cornerRadius = nameTextField.frame.height / 2
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.masksToBounds = true
        
        createButton.layer.cornerRadius = createButton.frame.height / 2
        createButton.layer.masksToBounds = true
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let error = validateFields()
        if error != nil {
            showError(message: error!)
        } else {
            let fullName = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.showError(message: "Error Creating User")
                } else {
                    DataManager.shared.user.name = fullName
                    DataManager.shared.user.id = result!.user.uid
                    DataManager.shared.setDataUser()
                    let customBarViewController = CustomBarViewController()
                    self.navigationController?.pushViewController(customBarViewController, animated: true)
                }
                
            }
        }
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
            return "please make sure your password is at least 8 characters"
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
    
}
