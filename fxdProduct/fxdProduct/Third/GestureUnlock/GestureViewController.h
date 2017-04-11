
#import <UIKit/UIKit.h>
typedef enum{
    GestureViewControllerTypeSetting = 1,
    GestureViewControllerTypeLogin
}GestureViewControllerType;

typedef enum{
    buttonTagReset = 1,
    buttonTagManager,
    buttonTagForget
    
}buttonTag;

@protocol GestureViewDelegate <NSObject>

- (void)setSwithchState:(BOOL)state;

@end

@interface GestureViewController : UIViewController

/**
 *  控制器来源类型
 */
@property (nonatomic, assign) GestureViewControllerType type;


@property (nonatomic, weak) id <GestureViewDelegate>delegate;

@end
