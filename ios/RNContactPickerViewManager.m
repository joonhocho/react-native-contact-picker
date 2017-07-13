//
//  RNContactViewManager.m
//  ExampleApp
//
//  Created by Joon Ho Cho on 4/16/17.
//  Copyright © 2017 Facebook. All rights reserved.
//

#import <ContactsUI/ContactsUI.h>

#import <React/RCTComponent.h>
#import <React/RCTViewManager.h>


@interface RCT_EXTERN_MODULE(RNContactPickerViewManager, RCTViewManager)

RCT_EXTERN_METHOD((UIView *)view);

RCT_EXPORT_VIEW_PROPERTY(contact, NSDictionary)

@end
