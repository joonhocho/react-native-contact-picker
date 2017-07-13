//
//  RNContactViewManager.swift
//  ExampleApp
//
//  Created by Joon Ho Cho on 4/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

import Foundation

@objc(RNContactViewManager)
class RNContactViewManager: RCTViewManager {
  @objc override func constantsToExport() -> [String: Any] {
    return [
      "dark": "dark",
      "light": "light",
      "iconOnly": "iconOnly",
      "standard": "standard",
      "wide": "wide",
    ]
  }
  
  @objc override func view() -> UIView {
    return RNContactView()
  }
}
