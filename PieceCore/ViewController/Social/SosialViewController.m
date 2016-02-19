//
//  SosialViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/12.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "SosialViewController.h"
#import "TWActivity.h"
#import "FBActivity.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>
#import "Common.h"

@interface SosialViewController ()
@property (nonatomic)ACAccountStore *accountStore;
@property (nonatomic)ACAccountStore *facebookAccount;
//@property (nonatomic) UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (nonatomic) UIImage *setImg;
@end

@implementation SosialViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"SosialViewController" owner:self options:nil];
}

- (void)viewDidLoadLogic {
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].sosialTitle;
    }
    self.accountStore = [[ACAccountStore alloc] init];
    [self setImgView];
    
}
-(void)setSosialBtn{
    
}
-(void)setImgView {
    
    self.imgView.tag = 1;
    self.imgView.contentMode = UIViewContentModeTop;
    UIImage *img = [UIImage imageNamed:@"camera.png"];
    self.imgView.image = img;

    
    self.imgView.userInteractionEnabled = YES;
    self.imgView.multipleTouchEnabled = YES;
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.imgView addGestureRecognizer: [[UITapGestureRecognizer alloc]
                                         initWithTarget:self action:@selector(showActionSheet)]];
        [self.view addSubview:self.imgView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]init];
    [actionSheet setDelegate:self];
    [actionSheet setTitle:@"写真を選びます"];
    [actionSheet addButtonWithTitle:@"ライブラリから選択"];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [actionSheet addButtonWithTitle:@"カメラで撮影"];
        [actionSheet setCancelButtonIndex:2];
    }else{
        [actionSheet setCancelButtonIndex:1];
    }
    [actionSheet addButtonWithTitle:@"キャンセル"];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setDelegate:self];
    switch (buttonIndex) {
        case 0:
            [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            //[self presentModalViewController:imagePicker animated:YES];
            [self presentViewController:imagePicker animated:YES completion:nil];
            break;
        case 1:
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentViewController:imagePicker animated:YES completion:nil];
            //[self presentModalViewController:imagePicker animated:YES];
            break;
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    //[self.gazou_iv setImage:image];
    [self.imgView setImage:image];
    self.setImg = image;
//    [self.imgView setImage:[[[ImageUtil alloc]init] imageByShrinkingWithSize:CGSizeMake(180, 180) uiImage:image maginW:0 maginH:0]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //    [self dismissModalViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)pressBtn {
    
    NSMutableArray *activityItems = [NSMutableArray array];
    if (self.sosialSetting.shareMessage != nil) {
        [activityItems addObject:self.sosialSetting.shareMessage];
    }
    if (self.sosialSetting.shareUrl != nil) {
        [activityItems addObject:self.sosialSetting.shareMessage];
    }
    if (self.setImg != nil) {
        [activityItems addObject:self.setImg];
    }
    NSArray *excludedActivityTypes = @[UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypeAirDrop];
    
    
    NSMutableArray *addActivties = [NSMutableArray array];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter] == NO) {
        TWActivity *twitterActivity  = [[TWActivity alloc] init];
        [addActivties addObject:twitterActivity];
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook] == NO) {
        FBActivity *fbActivity  = [[FBActivity alloc] init];
        [addActivties addObject:fbActivity];
    }
    
    UIActivityViewController *activityVc = [[UIActivityViewController alloc] initWithActivityItems:activityItems
                                                                             applicationActivities:addActivties];
    activityVc.excludedActivityTypes = excludedActivityTypes;
    [self presentViewController:activityVc animated:YES completion:nil];
}

@end
