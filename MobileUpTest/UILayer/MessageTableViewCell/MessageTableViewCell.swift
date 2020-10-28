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
    dateLabel.text = getFormattedDate(from: dateString)
    
    personImageView.kf.setImage(with: imageUrl)
  }
  
  private func getFormattedDate(from dateString: String?) -> String? {
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "dd MMMM yyyy"

    let date = dateFormatterGet.date(from: dateString ?? "") ?? Date()
    
    if Calendar.current.isDateInYesterday(date) {
      return "Yesterday"
    }
    
    if Calendar.current.isDateInToday(date) {
      dateFormatterPrint.dateFormat = "HH:mm"
      return dateFormatterPrint.string(from: date)
    }
    
    return dateFormatterPrint.string(from: date)
  }
}
