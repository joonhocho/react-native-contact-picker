//
//  RNContactView.swift
//  ExampleApp
//
//  Created by Joon Ho Cho on 4/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//
import Foundation
import UIKit
import ContactsUI
import Contacts

@objc(RNContactView)
class RNContactView: UIView, CNContactPickerDelegate {
  var controller: CNContactPickerViewController?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  convenience init() {
    self.init(frame: CGRect.zero)
  }
  
  required init(coder aDecoder: NSCoder) {
    fatalError("This class does not support NSCoding")
  }
  
  func genericLabel(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "home":
        return CNLabelHome
      case "work":
        return CNLabelWork
      case "other":
        return CNLabelOther
      default:
        return label
      }
    }
    return label
  }
  
  func phoneNumberLabel(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "iphone":
        return CNLabelPhoneNumberiPhone
      case "mobile":
        return CNLabelPhoneNumberMobile
      case "main":
        return CNLabelPhoneNumberMain
      case "homefax", "home fax", "home_fax":
        return CNLabelPhoneNumberHomeFax
      case "workfax", "work fax", "work_fax":
        return CNLabelPhoneNumberWorkFax
      case "otherfax", "other fax", "other_fax":
        return CNLabelPhoneNumberOtherFax
      case "pager":
        return CNLabelPhoneNumberPager
      default:
        return genericLabel(label)
      }
    }
    return label
  }
  
  func emailLabel(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "icloud":
        return CNLabelEmailiCloud
      default:
        return genericLabel(label)
      }
    }
    return label
  }
  
  func urlLabel(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "homepage":
        return CNLabelURLAddressHomePage
      default:
        return genericLabel(label)
      }
    }
    return label
  }
  
  func dateLabel(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "anniversary":
        return CNLabelDateAnniversary
      default:
        return genericLabel(label)
      }
    }
    return label
  }
  
  func relationLabel(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "father":
        return CNLabelContactRelationFather
      case "mother":
        return CNLabelContactRelationMother
      case "parent":
        return CNLabelContactRelationParent
      case "brother":
        return CNLabelContactRelationBrother
      case "sister":
        return CNLabelContactRelationSister
      case "child":
        return CNLabelContactRelationChild
      case "friend":
        return CNLabelContactRelationFriend
      case "spouse":
        return CNLabelContactRelationSpouse
      case "partner":
        return CNLabelContactRelationPartner
      case "assistant":
        return CNLabelContactRelationAssistant
      case "manager":
        return CNLabelContactRelationManager
      default:
        return genericLabel(label)
      }
    }
    return label
  }
  
  func socialProfileService(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "facebook":
        return CNSocialProfileServiceFacebook
      case "flickr":
        return CNSocialProfileServiceFlickr
      case "linkedin":
        return CNSocialProfileServiceLinkedIn
      case "myspace":
        return CNSocialProfileServiceMySpace
      case "sinaweibo":
        return CNSocialProfileServiceSinaWeibo
      case "weibo", "tencentweibo", "tencent weibo", "tencent_weibo":
        return CNSocialProfileServiceTencentWeibo
      case "twitter":
        return CNSocialProfileServiceTwitter
      case "yelp":
        return CNSocialProfileServiceYelp
      case "gamecenter", "game center", "game_center":
        return CNSocialProfileServiceGameCenter
      default:
        return label
      }
    }
    return label
  }
  
  func instantMessageService(_ label: String?) -> String? {
    if let label = label {
      switch label.lowercased() {
      case "aim":
        return CNInstantMessageServiceAIM
      case "facebook":
        return CNInstantMessageServiceFacebook
      case "gadugadu":
        return CNInstantMessageServiceGaduGadu
      case "googletalk", "google talk", "google_talk":
        return CNInstantMessageServiceGoogleTalk
      case "icq":
        return CNInstantMessageServiceICQ
      case "jabber":
        return CNInstantMessageServiceJabber
      case "msn":
        return CNInstantMessageServiceMSN
      case "qq":
        return CNInstantMessageServiceQQ
      case "skype":
        return CNInstantMessageServiceSkype
      case "yahoo":
        return CNInstantMessageServiceYahoo
      default:
        return label
      }
    }
    return label
  }
  
  func createContact(_ data: [String: Any]) -> CNMutableContact {
    // Creating a mutable object to add to the contact
    let contact = CNMutableContact()
    
    if let value = data["contactType"] as? String {
      contact.contactType = value == "organization" ? .organization : .person
    }
    
    if let value = data["namePrefix"] as? String {
      contact.namePrefix = value
    }
    if let value = data["givenName"] as? String {
      contact.givenName = value
    }
    if let value = data["middleName"] as? String {
      contact.middleName = value
    }
    if let value = data["familyName"] as? String {
      contact.familyName = value
    }
    if let value = data["previousFamilyName"] as? String {
      contact.previousFamilyName = value
    }
    if let value = data["nameSuffix"] as? String {
      contact.nameSuffix = value
    }
    if let value = data["nickname"] as? String {
      contact.nickname = value
    }
    
    if let value = data["organizationName"] as? String {
      contact.organizationName = value
    }
    if let value = data["departmentName"] as? String {
      contact.departmentName = value
    }
    if let value = data["jobTitle"] as? String {
      contact.jobTitle = value
    }
    
    if let value = data["phoneticGivenName"] as? String {
      contact.phoneticGivenName = value
    }
    if let value = data["phoneticMiddleName"] as? String {
      contact.phoneticMiddleName = value
    }
    if let value = data["phoneticFamilyName"] as? String {
      contact.phoneticFamilyName = value
    }
    if let value = data["phoneticOrganizationName"] as? String {
      contact.phoneticOrganizationName = value
    }
    
    if let value = data["note"] as? String {
      contact.note = value
    }
    
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
    
    return contact
  }
  
  func initContactViewController(_ contact: CNContact) {
    // Creating a mutable object to add to the contact
    DispatchQueue.main.async {
      if let vc = self.controller {
        vc.delegate = nil
        vc.removeFromParentViewController()
        vc.view.removeFromSuperview()
      }
      
      let vc = CNContactPickerViewController()
      self.controller = vc
      vc.delegate = self
      vc.view.frame = self.frame
      self.addSubview(vc.view)
    }
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    controller?.view.frame = bounds
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    
  }
}
