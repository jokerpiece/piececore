//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import "BaseViewController.h"

@interface TabbarData : NSObject
@property (nonatomic,strong) BaseViewController *viewController;
@property (nonatomic,strong) NSString *imgName;
@property (nonatomic,strong) NSString *selectImgName;
@property(nonatomic,strong) NSDictionary *tabFontStyle;
@property(nonatomic,strong) NSString *tabTitle;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *titleImgName;

-(id)initWithViewController:(BaseViewController *)viewController
                      imgName:(NSString *)imgName
                selectImgName:(NSString *)selectImgName
                        tabTitle:(NSString *)tabTitle
                        title:(NSString *)title;

-(id)initWithViewController:(BaseViewController *)viewController
                    imgName:(NSString *)imgName
              selectImgName:(NSString *)selectImgName
                   tabTitle:(NSString *)tabTitle
                      titleImgName:(NSString *)titleImgName;

-(id)initWithViewController:(BaseViewController *)viewController
                   tabTitle:(NSString *)tabTitle
                      title:(NSString *)title;
@end
