//
//  MessagesViewController.swift
//  MobileUpTest
//
//  Created by Антон Захарченко on 27.10.2020.
//

import UIKit

final class MessagesViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
  let messages: [String] = []
  
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
    
    cell.configure(
      name: <#String?#>,
      messageText: <#String?#>,
      dateString: <#String?#>,
      imageUrlString: <#String?#>)
    
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
