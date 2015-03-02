//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NetworkConecter.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "BaseConnector.h"
#import "SVProgressHUD.h"
#import "RoundBtn.h"
#import "Common.h"
#import "UIColor+MLPFlatColors.h"
#import "PieceCoreConfig.h"
#import "DLog.h"

@interface BaseViewController : UIViewController<NetworkDelegate, SDWebImageManagerDelegate>
@property (strong, nonatomic) BaseConnector *connecter;
@property (nonatomic) bool isResponse;
@property (strong, nonatomic) NSString *titleImgName;
@property (nonatomic) CGSize viewSize;
-(void)showAlert:(BaseConnector *)data;
-(void)showAlert:(NSString *)title message:(NSString *)message;
-(void)viewDidLoadLogic;
-(void)viewDidAppearLogic;
- (void)viewWillAppearLogic;
- (void)viewWillDisappearLogic;
@end
