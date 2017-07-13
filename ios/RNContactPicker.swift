import Foundation
import UIKit
import Contacts
import ContactsUI

private class PickContactDelegate: NSObject, CNContactPickerDelegate {
  let resolve: RCTPromiseResolveBlock
  let reject: RCTPromiseRejectBlock
  
  init(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    self.resolve = resolve
    self.reject = reject
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    reject("cancel", "User Cancelled", nil)
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
    resolve(RNContactPicker.contactToDictionary(contact))
  }
}

private class PickContactsDelegate: NSObject, CNContactPickerDelegate {
  let resolve: RCTPromiseResolveBlock
  let reject: RCTPromiseRejectBlock
  
  init(resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    self.resolve = resolve
    self.reject = reject
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    reject("cancel", "User Cancelled", nil)
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
    resolve(contacts.map { x in RNContactPicker.contactToDictionary(x) })
  }
}

@objc(RNContactPicker)
class RNContactPicker: NSObject {
  @objc func constantsToExport() -> [String: Any] {
    return [
      "name": "RNContactPicker",
    ]
  }
  
  @objc func pickContact(_ data: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    let vc = CNContactPickerViewController()
    vc.delegate = PickContactDelegate(resolve: resolve, reject: reject)
    
    if let displayedPropertyKeys = data["displayedPropertyKeys"] as? [String] {
      vc.displayedPropertyKeys = displayedPropertyKeys
    }
    
    DispatchQueue.main.async {
      UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
  }
  
  @objc func pickContacts(_ data: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    let vc = CNContactPickerViewController()
    vc.delegate = PickContactsDelegate(resolve: resolve, reject: reject)
    
    if let displayedPropertyKeys = data["displayedPropertyKeys"] as? [String] {
      vc.displayedPropertyKeys = displayedPropertyKeys
    }
    
    DispatchQueue.main.async {
      UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
  }
  
  
  static func addString(data: inout [String: Any], key: String, value: String?) {
    if let x = value, !x.isEmpty {
      data[key] = x
    }
  }
  
  static func contactToDictionary(_ contact: CNContact) -> [String: Any] {
    var data = [String: Any]()
    
    addString(data: &data, key: "identifier", value: contact.identifier)
    
    switch contact.contactType {
    case .organization:
      data["contactType"] = "organization"
      break
    case .person:
      data["contactType"] = "person"
    }
    
    addString(data: &data, key: "namePrefix", value: contact.namePrefix)
    addString(data: &data, key: "givenName", value: contact.givenName)
    addString(data: &data, key: "middleName", value: contact.middleName)
    addString(data: &data, key: "familyName", value: contact.familyName)
    addString(data: &data, key: "previousFamilyName", value: contact.previousFamilyName)
    addString(data: &data, key: "nameSuffix", value: contact.nameSuffix)
    addString(data: &data, key: "nickname", value: contact.nickname)
    
    addString(data: &data, key: "organizationName", value: contact.organizationName)
    addString(data: &data, key: "departmentName", value: contact.departmentName)
    addString(data: &data, key: "jobTitle", value: contact.jobTitle)
    
    addString(data: &data, key: "phoneticGivenName", value: contact.phoneticGivenName)
    addString(data: &data, key: "phoneticMiddleName", value: contact.phoneticMiddleName)
    addString(data: &data, key: "phoneticFamilyName", value: contact.phoneticFamilyName)
    if #available(iOS 10.0, *) {
      addString(data: &data, key: "phoneticOrganizationName", value: contact.phoneticOrganizationName)
    }
    
    addString(data: &data, key: "note", value: contact.note)
    
    /*
     if let value = data["imageData"] as? String {
     contact.imageData = Data(base64Encoded: value, options: .ignoreUnknownCharacters)
     } else if let value = data["imageUri"] as? String, let url = URL(string: value) {
     do {
     contact.imageData = try Data(contentsOf: url, options: .uncached)
     } catch {
     // do nothing
     }
     }
     
     if let value = data["phoneNumbers"] as? [[String: Any]] {
     contact.phoneNumbers = value.map { val in
     return CNLabeledValue(label: phoneNumberLabel(val["label"] as? String), value: CNPhoneNumber(stringValue: (val["value"] as? String)!))
     }
     }
     
     if let value = data["emailAddresses"] as? [[String: Any]] {
     contact.emailAddresses = value.map { val in
     return CNLabeledValue(label: emailLabel(val["label"] as? String), value: (val["value"] as? NSString)!)
     }
     }
     
     if let value = data["postalAddresses"] as? [[String: Any]] {
     contact.postalAddresses = value.map { val in
     let item = CNMutablePostalAddress()
     
     if let v = val["street"] as? String {
     item.street = v
     }
     if #available(iOS 10.3, *) {
     if let v = val["subLocality"] as? String {
     item.subLocality = v
     }
     }
     if let v = val["city"] as? String {
     item.city = v
     }
     if #available(iOS 10.3, *) {
     if let v = val["subAdministrativeArea"] as? String {
     item.subAdministrativeArea = v
     }
     }
     if let v = val["state"] as? String {
     item.state = v
     }
     if let v = val["postalCode"] as? String {
     item.postalCode = v
     }
     if let v = val["country"] as? String {
     item.country = v
     }
     if let v = val["isoCountryCode"] as? String {
     item.isoCountryCode = v
     }
     
     return CNLabeledValue(label: genericLabel(val["label"] as? String), value: item)
     }
     }
     
     if let value = data["urlAddresses"] as? [[String: Any]] {
     contact.urlAddresses = value.map { val in
     return CNLabeledValue(label: urlLabel(val["label"] as? String), value: (val["value"] as? NSString)!)
     }
     }
     
     if let value = data["contactRelations"] as? [[String: Any]] {
     contact.contactRelations = value.map { val in
     return CNLabeledValue(label: relationLabel(val["label"] as? String), value: CNContactRelation(name: (val["value"] as? String)!))
     }
     }
     
     if let value = data["socialProfiles"] as? [[String: Any]] {
     contact.socialProfiles = value.map { val in
     let item = CNSocialProfile(
     urlString: val["urlString"] as? String,
     username: val["username"] as? String,
     userIdentifier: val["userIdentifier"] as? String,
     service: socialProfileService(val["service"] as? String)
     )
     return CNLabeledValue(label: genericLabel(val["label"] as? String), value: item)
     }
     }
     
     if let value = data["instantMessageAddresses"] as? [[String: Any]] {
     contact.instantMessageAddresses = value.map { val in
     let item = CNInstantMessageAddress(username: (val["username"] as? String)!, service: instantMessageService(val["service"] as? String)!)
     return CNLabeledValue(label: genericLabel(val["label"] as? String), value: item)
     }
     }
     
     if let value = data["birthday"] as? [String: Any] {
     var item = DateComponents()
     if let v = value["year"] as? Int {
     item.year = v
     }
     if let v = value["month"] as? Int {
     item.month = v
     }
     if let v = value["day"] as? Int {
     item.day = v
     }
     contact.birthday = item
     }
     
     if let value = data["nonGregorianBirthday"] as? [String: Any] {
     var item = DateComponents()
     if let v = value["year"] as? Int {
     item.year = v
     }
     if let v = value["month"] as? Int {
     item.month = v
     }
     if let v = value["day"] as? Int {
     item.day = v
     }
     contact.nonGregorianBirthday = item
     }
     
     if let value = data["dates"] as? [[String: Any]] {
     contact.dates = value.map { val in
     let item = NSDateComponents()
     if let v = val["year"] as? Int {
     item.year = v
     }
     if let v = val["month"] as? Int {
     item.month = v
     }
     if let v = val["day"] as? Int {
     item.day = v
     }
     return CNLabeledValue(label: dateLabel(val["label"] as? String), value: item)
     }
     }
     
     */
    
    return data
  }

}
