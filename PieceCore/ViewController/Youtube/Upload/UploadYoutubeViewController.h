//
//  MovieUploadViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/11/06.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "BaseViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface UploadYoutubeViewController : BaseViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *movieTitleTf;
@property (weak, nonatomic) IBOutlet UITextView *movieTv;
@property (weak, nonatomic) IBOutlet UIButton *movieSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *movieUploadBtn;
- (IBAction)movieSelectAction:(id)sender;
- (IBAction)movieUploadAction:(id)sender;

@end
