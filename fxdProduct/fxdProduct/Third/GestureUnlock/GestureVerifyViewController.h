
#import <UIKit/UIKit.h>

@protocol GestureVerifyDelegate <NSObject>

- (void)gestureVerifyState;

@end

@interface GestureVerifyViewController : UIViewController

@property (nonatomic, assign) BOOL isToSetNewGesture;

@property (nonatomic, weak) id <GestureVerifyDelegate>delegate;

@end
