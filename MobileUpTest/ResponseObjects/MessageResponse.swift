//
//  MessageResponse.swift
//  MobileUpTest
//
//  Created by Антон Захарченко on 28.10.2020.
//

import Foundation

struct MessageResponse: Codable {
  let message: Message?
  let user: UserInfo?
  
  struct Message: Codable {
    let receiving_date: String?
    let text: String?
  }
  
  struct UserInfo: Codable {
    let avatar_url: String?
    let nickname: String?
  }
}
