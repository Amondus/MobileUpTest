//
//  MessagesViewController.swift
//  MobileUpTest
//
//  Created by Антон Захарченко on 27.10.2020.
//

import UIKit

final class MessagesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  let messages: [MessageResponse] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    tableView.dataSource = self
    
    registerCells()
    fetchMessages()
  }
  
  private func fetchMessages() {
    
  }
  
  // MARK: - Configure Cells
  
  private func registerCells() {
    tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil),
                       forCellReuseIdentifier: "MessageTableViewCell")
  }
  
  private func createMessageCell(indexPath: IndexPath) -> MessageTableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as? MessageTableViewCell else
    {
      return MessageTableViewCell()
      
    }
    
    let message = messages[indexPath.row]
    
    cell.configure(
      name: message.user?.nickname,
      messageText: message.message?.text,
      dateString: message.message?.receiving_date,
      imageUrlString: message.user?.avatar_url)
    
    return cell
  }
}

// MARK: - UITableViewDataSource Methods

extension MessagesViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return createMessageCell(indexPath: indexPath)
  }
}
