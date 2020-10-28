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
  @IBOutlet weak var errorLabel: UILabel!
  @IBOutlet weak var activityIndicationView: UIActivityIndicatorView!
  
  private let disposeBag = DisposeBag()
  
  private var messages: [MessageResponse] = []
  
  // MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = true
    
    setupTableView()
    fetchMessages()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    activityIndicationView.isHidden = false
    activityIndicationView.startAnimating()
  }
  
  // MARK: - Private Methods
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.layer.isHidden = true
    errorLabel.layer.isHidden = true
    
    registerCells()
  }
  
  private func fetchMessages() {
    let stringUrl = "https://s3-eu-west-1.amazonaws.com/builds.getmobileup.com/storage/MobileUp-Test/api.json"
    guard let url = URL(string: stringUrl) else { return }
    let resource = Resource<[MessageResponse]>(url: url, httpMethod: .get)
    
    URLRequest.load(resource: resource)
      .subscribe (onNext: { result in
        self.messages = result
        self.reloadTableView()
      }, onError: { _ in
        self.configureErrorView()
      }).disposed(by: disposeBag)
  }
  
  private func configureErrorView() {
    DispatchQueue.main.async { [weak self] in
      self?.activityIndicationView.layer.isHidden = true
      self?.errorLabel.layer.isHidden = false
    }
  }
  
  private func reloadTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.activityIndicationView.layer.isHidden = true
      self?.tableView.layer.isHidden = self?.messages.isEmpty ?? true
      self?.errorLabel.layer.isHidden = !(self?.messages.isEmpty ?? true)
      
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
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 76
  }
}
