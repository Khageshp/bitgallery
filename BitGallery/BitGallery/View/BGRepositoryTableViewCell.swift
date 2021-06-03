//
//  BGRepositoryTableViewCell.swift
//  BitGallery
//
//  Created by Khagesh Patel on 2/6/21.
//

import UIKit

class BGRepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func loadData(data: BGValue?) {
        resetFields()
        if let data = data {
            nameLabel.text = data.name
            typeLabel.text = data.type?.rawValue
            dateLabel.text = data.createdOn
            if let avatarURLString = data.links?.avatar?.href {
                if let imageData = BGDataManager.shared.cachedImages[avatarURLString] as? Data {
                    avatarImageView.loadImage(data: imageData)
                } else if let url = URL(string: avatarURLString) {
                    avatarImageView.load(url: url)
                }
            }
        }
    }
    
    func resetFields() {
        avatarImageView.image = nil
        nameLabel.text = ""
        typeLabel.text = ""
        dateLabel.text = ""
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                BGDataManager.shared.cachedImages[url.absoluteString] = data
                self?.loadImage(data: data)
            }
        }
    }
    
    func loadImage(data: Data) {
        if let image = UIImage(data: data) {
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
