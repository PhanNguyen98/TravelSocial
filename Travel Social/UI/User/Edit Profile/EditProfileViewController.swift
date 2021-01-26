//
//  EditProfileViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 24/01/2021.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    @IBOutlet weak var placeTextField: UITextField!
    
    var imagePicker: ImagePicker!
    var fileName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setUI()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataImageManager.shared.downloadImage(path: "avatar", nameImage: DataManager.shared.user.nameImage!)
        self.avatarImageView.image = DataImageManager.shared.resultImage
        self.nameTextField.text = DataManager.shared.user.name
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'-'MM'-'yyyy"
        guard let birthdate = DataManager.shared.user.birthday else { return }
        let date = dateFormatter.date(from: birthdate)
        self.birthdayDatePicker.date = date ?? Date()
        self.placeTextField.text = DataManager.shared.user.place
    }

    @IBAction func changeAvatarProfile(_ sender: UIButton) {
        self.imagePicker.present(from: sender)
    }
    
    func setUI() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        nameTextField.layer.cornerRadius = 3
        placeTextField.layer.cornerRadius = 3
    }
    
    func setNavigation() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(popViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(saveProfile))
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveProfile() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        DataManager.shared.user.birthday = formatter.string(from: birthdayDatePicker.date)
        DataManager.shared.user.name = nameTextField.text
        if let nameImage = fileName {
            DataManager.shared.user.nameImage = nameImage
        }
        DataManager.shared.user.place = placeTextField.text
        DataImageManager.shared.uploadsImage(image: avatarImageView.image!, place: "avatar", nameImage: fileName ?? "")
        DataManager.shared.setDataUser()
        DataManager.shared.getUserFromId(id: DataManager.shared.user.id!)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension EditProfileViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.avatarImageView.image = image
    }
    
    func getFileName(fileName: String?) {
        self.fileName = fileName
    }
    
}
