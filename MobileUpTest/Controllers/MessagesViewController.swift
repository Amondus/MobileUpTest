//
//  MessagesViewController.swift
//  MobileUpTest
//
//  Created by Антон Захарченко on 27.10.2020.
//

import UIKit
import RxSwift
import RxCocoa

final class MessagesViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var messages: [MessageResponse] = []
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    tableView.dataSource = self
    tableView.delegate = self
    
    registerCells()
    fetchMessages()
  }
  
  private func fetchMessages() {
    let stringUrl = "https://s3-eu-west-1.amazonaws.com/builds.getmobileup.com/storage/MobileUp-Test/api.json"
    guard let url = URL(string: stringUrl) else { return }
    let resource = Resource<[MessageResponse]>(url: url, httpMethod: .get)
    
    URLRequest.load(resource: resource)
      .subscribe (onNext: { result in
        self.messages = result
        self.reloadTableView()
      }).disposed(by: disposeBag)
  }
  
  private func reloadTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
    }
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

// MARK: - UITableViewDelegate Methods

extension MessagesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
