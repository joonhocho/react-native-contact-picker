import Foundation

@objc(RNContactPickerViewManager)
class RNContactPickerViewManager: RCTViewManager {
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
    return RNContactPickerView()
  }
}
