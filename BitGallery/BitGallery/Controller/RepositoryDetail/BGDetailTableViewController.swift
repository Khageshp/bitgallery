//
//  BGCloneTableViewController.swift
//  BitGallery
//
//  Created by Khagesh Patel on 3/6/21.
//

import UIKit

class BGRepositoryDetailTableViewController: UITableViewController {

    var value: BGValue?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!

    @IBOutlet weak var uuidLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail"
        nameLabel?.text = value?.fullName ?? "No full name available"
        languageLabel?.text = value?.language ?? "No language available"
        uuidLabel?.text = value?.uuid ?? "No uuid available"
        loadImageView()
    }

    func loadImageView() {
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
        avatarImageView.layer.borderWidth = 0.5
        avatarImageView.layer.borderColor = UIColor.darkGray.cgColor
        avatarImageView.backgroundColor = .lightGray

        if let avatarURLString = value?.links?.avatar?.href {
            if let imageData = BGDataManager.shared.cachedImages[avatarURLString] as? Data {
                avatarImageView.loadImage(data: imageData)
            } else if let url = URL(string: avatarURLString) {
                avatarImageView.load(url: url)
            }
        }
    }

}
