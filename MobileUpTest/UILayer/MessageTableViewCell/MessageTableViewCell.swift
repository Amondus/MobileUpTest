//
//  MessageTableViewCell.swift
//  MobileUpTest
//
//  Created by Антон Захарченко on 27.10.2020.
//

import UIKit
import Kingfisher

final class MessageTableViewCell: UITableViewCell {
  
  @IBOutlet weak var personImageView: UIImageView!
  @IBOutlet weak var personNameLabel: UILabel!
  @IBOutlet weak var messageTextLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setImageStyle()
  }
  
  private func setImageStyle() {
    personImageView.layer.cornerRadius = personImageView.frame.height / 2
    personImageView.clipsToBounds = true
  }
  
  func configure(
    name: String?,
    messageText: String?,
    dateString: String?,
    imageUrlString: String?)
  {
    let imageUrl = URL(string: imageUrlString ?? "")
    
    personNameLabel.text = name
    messageTextLabel.text = messageText
    dateLabel.text = dateString
    
    personImageView.kf.setImage(with: imageUrl)
  }
}
