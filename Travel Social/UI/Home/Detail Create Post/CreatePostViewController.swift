//
//  PostViewController.swift
//  Travel Social
//
//  Created by Phan Nguyen on 22/01/2021.
//

import UIKit
import OpalImagePicker
import Photos

class CreatePostViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var selectImageButton: UIButton!
    
    var resultImagePicker = [PHAsset]()
    var dataPost = Post(id: DataManager.shared.user.id!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        setDataUser()
    }
    
    func setUI() {
        nameLabel.underline()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        contentTextView.delegate = self
        contentTextView.layer.cornerRadius = 10
        contentTextView.layer.borderWidth = 0.3
        contentTextView.layer.borderColor = UIColor.black.cgColor
        selectImageButton.layer.cornerRadius = 5
        selectImageButton.layer.masksToBounds = true
    }
    
    func setDataUser() {
        DataImageManager.shared.downloadImage(path: "avatar", nameImage: DataManager.shared.user.nameImage!) { result in
            DispatchQueue.main.async() {
                self.avatarImageView.image = result
            }
        }
        nameLabel.text = DataManager.shared.user.name
    }
    
    func setNavigationBar() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(popViewController))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "POST", style: .plain, target: self, action: #selector(pushPost))
    }
    
    @IBAction func selectImage(_ sender: Any) {
        let imagePicker = OpalImagePickerController()
        imagePicker.imagePickerDelegate = self
        imagePicker.selectionTintColor = UIColor.white.withAlphaComponent(0.7)
        imagePicker.selectionImageTintColor = UIColor.black
        imagePicker.selectionImage = UIImage(systemName: "checkmark")
        imagePicker.statusBarPreference = UIStatusBarStyle.lightContent
        imagePicker.maximumSelectionsAllowed = 10
        imagePicker.allowedMediaTypes = Set([PHAssetMediaType.image])
        let configuration = OpalImagePickerConfiguration()
        configuration.maximumSelectionsAllowedMessage = NSLocalizedString("You cannot select that many images!", comment: "")
        imagePicker.configuration = configuration
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pushPost() {
        var resultImage = [String]()
        for asset in resultImagePicker {
            let assetResources = PHAssetResource.assetResources(for: asset)
            let nameImage = assetResources.first!.originalFilename
            resultImage.append(nameImage)
            DataImageManager.shared.uploadsImage(image: Utilities.getAssetThumbnail(asset: asset), place: "post", nameImage: nameImage)
        }
        if contentTextView.text != nil || dataPost.listImage != nil {
            dataPost.listImage = resultImage
            dataPost.content = contentTextView.text
            DataManager.shared.setDataPost(data: dataPost)
            self.navigationController?.popViewController(animated: true)
        }
    }

}

extension CreatePostViewController: UITextViewDelegate {
}

extension CreatePostViewController: OpalImagePickerControllerDelegate {
    
    func imagePicker(_ picker: OpalImagePickerController, didFinishPickingAssets assets: [PHAsset]) {
        resultImagePicker = assets
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerDidCancel(_ picker: OpalImagePickerController) {
        presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
}
