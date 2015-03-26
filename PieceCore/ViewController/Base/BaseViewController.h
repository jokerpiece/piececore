//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NetworkConecter.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "BaseRecipient.h"
#import "RoundBtn.h"
#import "Common.h"
#import "UIColor+MLPFlatColors.h"
#import "PieceCoreConfig.h"
#import "DLog.h"
#import "SosialSettingData.h"
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@interface BaseViewController : UIViewController<NetworkDelegate, SDWebImageManagerDelegate>
@property (strong, nonatomic) BaseRecipient *recipient;
@property (nonatomic) bool isResponse;
@property (strong, nonatomic) NSString *titleImgName;
@property (nonatomic) CGSize viewSize;
@property (nonatomic)SosialSettingData *sosialSetting;
@property (nonatomic) UIButton *sosialBtn;
-(void)showAlert:(BaseRecipient *)recipient;
-(void)showAlert:(NSString *)title message:(NSString *)message;
-(void)viewDidLoadLogic;
-(void)viewDidAppearLogic;
- (void)viewWillAppearLogic;
- (void)viewWillDisappearLogic;
-(void)setSosialBtn;
@end
