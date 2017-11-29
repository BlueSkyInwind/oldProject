

#import "BaseViewController.h"

@interface ShanLinWebVCModules : BaseViewController

//跳转的url
@property (nonatomic, copy)NSString *urlStr;
//js内容
@property (nonatomic, copy) NSString *loadContent;
//标题名字
@property (nonatomic,copy) NSString *name;
//隐藏navigationBar
@property (nonatomic,assign) BOOL isHidden;

@property (nonatomic,assign) BOOL isHaveAlert;

@end

