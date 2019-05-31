//
//  DateFormatterFactory.swift
//  BydrecTest
//
//  Created by Mariano Cornejo on 5/31/19.
//  Copyright © 2019 marianocornejo. All rights reserved.
//

import Foundation

public final class DateFormatterFactory {
  
  // MARK: - Singleton
  public static let shared: DateFormatterFactory = DateFormatterFactory()
  
  private init() {
    //DO NOTHING
  }
  
  // MARK: - Properties
  lazy var serverDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeZone = TimeZone(abbreviation: "UTC")
    formatter.dateFormat = Constants.DateFormat.server
    return formatter
  }()
  
  lazy var appDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .autoupdatingCurrent
    formatter.setLocalizedDateFormatFromTemplate(Constants.DateFormat.app)
    return formatter
  }()
}
