#import <ContactsUI/ContactsUI.h>

#import <React/RCTComponent.h>
#import <React/RCTViewManager.h>


@interface RCT_EXTERN_MODULE(RNContactPickerViewManager, RCTViewManager)

RCT_EXTERN_METHOD((UIView *)view);

RCT_EXPORT_VIEW_PROPERTY(onCancel, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onSelectContact, RCTBubblingEventBlock)

@end
