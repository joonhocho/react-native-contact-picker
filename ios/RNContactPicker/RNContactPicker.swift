import Foundation
import Contacts
import ContactsUI

class PickContactDelegate: NSObject, CNContactPickerDelegate {
  unowned let picker: RNContactPicker
  var resolve: RCTPromiseResolveBlock?
  var reject: RCTPromiseRejectBlock?
  
  init(picker: RNContactPicker, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    self.picker = picker
    self.resolve = resolve
    self.reject = reject
  }
  
  deinit {
    reject?("deinit", "Deinitialized", nil)
    clear()
  }
  
  func clear() {
    resolve = nil
    reject = nil
    self.picker.contactDelegate = nil
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    reject?("cancel", "User Cancelled", nil)
    clear()
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
    resolve?(RNContactPicker.contactToDictionary(contact))
    clear()
  }
}

class PickContactsDelegate: NSObject, CNContactPickerDelegate {
  unowned let picker: RNContactPicker
  var resolve: RCTPromiseResolveBlock?
  var reject: RCTPromiseRejectBlock?
  
  init(picker: RNContactPicker, resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    self.picker = picker
    self.resolve = resolve
    self.reject = reject
  }
  
  deinit {
    reject?("deinit", "Deinitialized", nil)
    clear()
  }
  
  func clear() {
    resolve = nil
    reject = nil
    self.picker.contactsDelegate = nil
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    reject?("cancel", "User Cancelled", nil)
    clear()
  }
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
    resolve?(contacts.map { x in RNContactPicker.contactToDictionary(x) })
    clear()
  }
}

@objc(RNContactPicker)
class RNContactPicker: NSObject {
  var contactDelegate: PickContactDelegate?
  var contactsDelegate: PickContactsDelegate?
  
  @objc func constantsToExport() -> [String: Any] {
    return [
      "name": "RNContactPicker",
    ]
  }
  
  @objc func pickContact(_ data: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    let vc = CNContactPickerViewController()
    contactDelegate = PickContactDelegate(picker: self, resolve: resolve, reject: reject)
    vc.delegate = contactDelegate
    
    if let displayedPropertyKeys = data["displayedPropertyKeys"] as? [String] {
      vc.displayedPropertyKeys = displayedPropertyKeys
    }
    
    DispatchQueue.main.async {
      UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: true, completion: nil)
    }
  }
  
  @objc func pickContacts(_ data: [String: Any], resolve: @escaping RCTPromiseResolveBlock, reject: @escaping RCTPromiseRejectBlock) {
    let vc = CNContactPickerViewController()
    contactsDelegate = PickContactsDelegate(picker: self, resolve: resolve, reject: reject)
    vc.delegate = contactsDelegate
    
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
  
  static func add(_ data: inout [String: Any], key: String, value: Any?) {
    if let x = value {
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
    
    addString(data: &data, key: "imageData", value: contact.imageData?.base64EncodedString())
    addString(data: &data, key: "thumbnailImageData", value: contact.thumbnailImageData?.base64EncodedString())
    data["imageDataAvailable"] = contact.imageDataAvailable
    
    data["phoneNumbers"] = contact.phoneNumbers.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      addString(data: &o, key: "value", value: val.value.stringValue)
      return o
      } as [[String: Any]]
    
    data["emailAddresses"] = contact.emailAddresses.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      addString(data: &o, key: "value", value: val.value as String)
      return o
      } as [[String: Any]]
    
    data["postalAddresses"] = contact.postalAddresses.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      addString(data: &o, key: "city", value: val.value.city)
      addString(data: &o, key: "country", value: val.value.country)
      addString(data: &o, key: "isoCountryCode", value: val.value.isoCountryCode)
      addString(data: &o, key: "postalCode", value: val.value.postalCode)
      addString(data: &o, key: "state", value: val.value.state)
      addString(data: &o, key: "street", value: val.value.street)
      if #available(iOS 10.3, *) {
        addString(data: &o, key: "subAdministrativeArea", value: val.value.subAdministrativeArea)
      }
      if #available(iOS 10.3, *) {
        addString(data: &o, key: "subLocality", value: val.value.subLocality)
      }
      return o
      } as [[String: Any]]
    
    data["urlAddresses"] = contact.urlAddresses.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      addString(data: &o, key: "value", value: val.value as String)
      return o
      } as [[String: Any]]
    
    data["contactRelations"] = contact.contactRelations.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      addString(data: &o, key: "value", value: val.value.name)
      return o
      } as [[String: Any]]
    
    data["socialProfiles"] = contact.socialProfiles.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      addString(data: &o, key: "service", value: val.value.service)
      addString(data: &o, key: "urlString", value: val.value.urlString)
      addString(data: &o, key: "userIdentifier", value: val.value.userIdentifier)
      addString(data: &o, key: "username", value: val.value.username)
      return o
      } as [[String: Any]]
    
    data["instantMessageAddresses"] = contact.instantMessageAddresses.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      addString(data: &o, key: "service", value: val.value.service)
      addString(data: &o, key: "username", value: val.value.username)
      return o
      } as [[String: Any]]
    
    if let value = contact.birthday {
      var o = [String: Any]()
      add(&o, key: "year", value: value.year)
      add(&o, key: "month", value: value.month)
      add(&o, key: "day", value: value.day)
      data["birthday"] = o
    }
    
    if let value = contact.nonGregorianBirthday {
      var o = [String: Any]()
      add(&o, key: "year", value: value.year)
      add(&o, key: "month", value: value.month)
      add(&o, key: "day", value: value.day)
      data["nonGregorianBirthday"] = o
    }
    
    data["dates"] = contact.dates.map { val in
      var o = [String: Any]()
      addString(data: &o, key: "identifier", value: val.identifier)
      addString(data: &o, key: "label", value: val.label)
      add(&o, key: "year", value: val.value.year)
      add(&o, key: "month", value: val.value.month)
      add(&o, key: "day", value: val.value.day)
      return o
      } as [[String: Any]]
    
    return data
  }

}
