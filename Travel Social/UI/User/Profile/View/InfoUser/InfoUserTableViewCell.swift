//
//  InfoUserTableViewCell.swift
//  Travel Social
//
//  Created by Phan Nguyen on 26/01/2021.
//

import UIKit

protocol InfoUserTableViewCellDelegate: class {
    func showEditProfile(viewController: UIViewController)
}

class InfoUserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton!
    
    weak var cellDelegate: InfoUserTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func editProfile(_ sender: Any) {
        let editProfileViewController = EditProfileViewController()
        self.cellDelegate?.showEditProfile(viewController: editProfileViewController)
    }
    
    func setUI() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        nameLabel.underline()
        birthdayLabel.underline()
        placeLabel.underline()
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 0.3
        editProfileButton.layer.borderColor = UIColor.black.cgColor
        editProfileButton.layer.masksToBounds = true
    }
    
    func setData(item: User) {
        nameLabel.text = item.name
        birthdayLabel.text = item.birthday
        placeLabel.text = item.place
        DataImageManager.shared.downloadImage(path: "avatar", nameImage: item.nameImage!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.avatarImageView.image = DataImageManager.shared.resultImage
        }
    }
    
}
