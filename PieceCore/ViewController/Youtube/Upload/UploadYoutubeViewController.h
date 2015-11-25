//
//  MovieUploadViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/06.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface UploadYoutubeViewController : BaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *movieTitleTf;
@property (weak, nonatomic) IBOutlet UITextView *movieTv;
@property (weak, nonatomic) IBOutlet UIButton *movieSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *movieUploadBtn;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UITextView *messageTV;
@property (weak, nonatomic) IBOutlet UIButton *messageRegistBtn;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *update_token;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *order_id;
@property (strong,nonatomic) NSString *movieId;
- (IBAction)movieSelectAction:(id)sender;
- (IBAction)movieUploadAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrView;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;



@end
