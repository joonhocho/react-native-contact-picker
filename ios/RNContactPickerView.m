#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>

@interface RNContactPickerView: UIView

@property (nonatomic, copy) RCTBubblingEventBlock onCancel;
@property (nonatomic, copy) RCTBubblingEventBlock onSelectContact;

@end
