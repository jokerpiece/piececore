//
//  OrderDataCheckViewController.h
//  pieceSample
//
//  Created by shinden nobuyuki on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import "YoutubeData.h"
@interface OrderDataCheckViewController : BaseViewController


@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextField *orderNumTxt;
@property (weak, nonatomic) IBOutlet UITextField *mailAddressTxt;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *order_num;
@property (nonatomic) NSString *order_id;
- (IBAction)onCancel:(id)sender;
@end
