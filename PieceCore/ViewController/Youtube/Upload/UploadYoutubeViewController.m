//
//  MovieUploadViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/06.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "UploadYoutubeViewController.h"
#import "FinishYoutubeUploadViewController.h"
#import "CoreDelegate.h"
@import Photos;
#import <AVFoundation/AVFoundation.h>

@interface UploadYoutubeViewController ()
@property (nonatomic) NSURL *movieURL;


@end

@implementation UploadYoutubeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endTextEdit:)];
    [self.view addGestureRecognizer:ges];
//    self.type = @"1";
//    self.order_id = @"10";
    if([self.type isEqualToString:@"3"]){
        self.messageView.hidden = NO;
        self.messageView.layer.borderColor = [UIColor blackColor].CGColor;
        [self.scrView setContentSize:CGSizeMake(0, 568)];
        
    }
    //    [self sendGetYoutubeWithToken];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)endTextEdit:(id)sender{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    [self.scrView setContentSize:CGSizeMake(0, 568)];
    [self.scrView setContentOffset:CGPointMake(0, 100)];
}

-(void)textViewShouldEndEditing: (UITextView*)textView{
    [self.scrView setContentSize:CGSizeMake(0, 568)];
}
- (IBAction)messageRegistAction:(id)sender {
    if(self.messageTV.text.length == 0){
        [self showAlert:@"エラー" message:@"メッセージが登録されていません。"];
    }else{
        [self uploadMovieInfo:@""];
    }
}

- (IBAction)movieSelectAction:(id)sender {
    [self chooseMovie];
}

//アップロード１
- (IBAction)movieUploadAction:(id)sender {
    if (self.movieURL == nil) {
        return;
    }
    [self getYoutubeMovieWithToken:self.token];
//    [self sendGetYoutubeWithToken];
}
-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [BaseRecipient alloc];
}

//アップロード２
-(void)sendGetYoutubeWithToken{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:self.order_id forKeyPath:@"order_num"];
    [param setValue:[Common getUuid] forKeyPath:@"uuid"];
    
//    [param setValue:@"6AA5E044-E002-4193-A4DB-BE583C501CC4" forKeyPath:@"uuid"];

    [conecter sendActionSendId:SendIdGetYoutubeToken param:param];
}

//アップロード４
-(void)sendPostYoutubeMovieWithToken:(NSString *)token VideoData:(NSData *)videoData{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:@"snippet"forKey:@"part"];
    NSMutableDictionary *headerParam = [NSMutableDictionary dictionary];
    
    //https://developers.google.com/youtube/v3/guides/using_resumable_upload_protocol?hl=ja_
    
    [headerParam setValue:[NSString stringWithFormat:@"Bearer %@",token] forKeyPath:@"Authorization"];
    [headerParam setValue:@"application/otet-stream" forKeyPath:@"Content-Type"];
    
    
    [conecter uploadActionUrl:SendIdPostYoutubeMovie headerParam:headerParam
                        param:param fileData:videoData pramName:@"file" fileName:[self.movieURL lastPathComponent] mineTipe:@"video/quicktime"];
    
}


//　アップロード３
-(void)getYoutubeMovieWithToken:(NSString *)token{
    
    
    // 取得したURLを使用して、PHAssetを取得する
    PHFetchResult *fetchResult = [PHAsset fetchAssetsWithALAssetURLs:@[self.movieURL,] options:nil];
    PHAsset *asset = fetchResult.firstObject;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = YES;
    [[PHCachingImageManager defaultManager] requestAVAssetForVideo:asset options:nil resultHandler:^(AVAsset *asset, AVAudioMix *audioMix, NSDictionary *info) {
        
        if ([asset isKindOfClass:[AVURLAsset class]]) {
            AVURLAsset* urlAsset = (AVURLAsset*)asset;
            NSNumber *size;
            
            [urlAsset.URL getResourceValue:&size forKey:NSURLFileSizeKey error:nil];
            DLog(@"size is %f",[size floatValue]/(1024.0*1024.0)); //size is 43.703005
            NSData *data = [NSData dataWithContentsOfURL:urlAsset.URL];
            DLog(@"length %f",[data length]/(1024.0*1024.0)); // data size is 43.703005
            [self sendPostYoutubeMovieWithToken:token VideoData:data];
        }
    }];
    
    
    
    
}

-(void)uploadMovieInfo:(NSString*)movieId{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //    [param setValue:[Common getUuid] forKeyPath:@"uuid"];
    [param setValue:movieId forKeyPath:@"youtube_id"];
    
    [param setValue:self.order_id forKey:@"order_id"];
    [param setValue:self.messageTV.text forKey:@"message"];
    [conecter sendActionSendId:SendIdPostMovieOrMessage param:param];
}

-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    
    DLog(@"%@",recipient.resultset);
    if(recipient.resultset[@"error_message"]){
        [self showAlert:@"エラー" message:recipient.resultset[@"error_message"]];
    }else{
        if([sendId isEqualToString:SendIdGetYoutubeToken]){
            self.order_id = recipient.resultset[@"order_id"];
            [self getYoutubeMovieWithToken:recipient.resultset[@"token"]];
        }else if([sendId isEqualToString:SendIdPostYoutubeMovie]){
            [self uploadMovieInfo:recipient.resultset[@"id"]];
        }else if([sendId isEqualToString:SendIdPostMovieOrMessage]){
            FinishYoutubeUploadViewController *fyu = [[FinishYoutubeUploadViewController alloc]init];
            if([Common isNotEmptyString:self.messageTV.text]){
                fyu.whereFrom = @"message";
            }
            [self.navigationController pushViewController:fyu animated:YES];
        }
    }
}

-(void)receiveError:(NSError *)error sendId:(NSString *)sendId{
    CoreDelegate *delegate = (CoreDelegate *)[[UIApplication sharedApplication] delegate];
    if (!delegate.isUpdate) {
        NSString *errMsg;
        if([sendId isEqualToString:SendIdPostYoutubeMovie]){
            errMsg = @"動画のアップロードに失敗しました。";
        }else{
            switch (error.code) {
                case NSURLErrorBadServerResponse:
                    errMsg = @"現在メンテナンス中です。\n大変申し訳ありませんがしばらくお待ち下さい。";
                    break;
                case NSURLErrorTimedOut:
                    errMsg = @"通信が混み合っています。\nしばらくしてからアクセスして下さい。";
                    break;
                    
                case kCFURLErrorNotConnectedToInternet:
                    errMsg = @"通信できませんでした。\n電波状態をお確かめ下さい。";
                    break;
                default:
                    errMsg = [NSString stringWithFormat:@"エラーコード：%ld",(long)error.code];
                    break;
            }
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:errMsg
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}



/*--------------------------------------------------------------------------------
 カメラロールからムービーを選択する
 --------------------------------------------------------------------------------*/
- (void)chooseMovie{
    
    // フォトライブラリが使えるか確認
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        
        // 使える
        UIImagePickerController *picker=[[UIImagePickerController alloc]init];
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes=@[(NSString*) kUTTypeMovie ]; // import MobileCoreServices
        picker.allowsEditing=NO;
        picker.delegate=self;
        picker.videoQuality=UIImagePickerControllerQualityTypeHigh;
        
        // 開く
        [self presentViewController:picker animated:YES completion:NULL];
        
    }else{
        // 使えない
        DLog(@"PhotoLibraryが使えない");
    }
}


/*--------------------------------------------------------------------------------
 UIImagePickerControllerで選択されたとき
 --------------------------------------------------------------------------------*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString*)kUTTypeMovie]){
        // 動画のURLを取得
        NSURL *url=[info objectForKey:UIImagePickerControllerReferenceURL];
        
        AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        gen.appliesPreferredTrackTransform = YES;
        CGImageRef image = [gen copyCGImageAtTime:CMTimeMakeWithSeconds(0.0, 300) actualTime:nil error:nil];
        self.thumbnail.image = [UIImage imageWithCGImage:image];
        
        DLog(@"動画の場所：%@",url.absoluteString);
        self.movieURL=url;
    }
    
    // 閉じる
    [self dismissViewControllerAnimated:YES completion:NULL];
}

/*--------------------------------------------------------------------------------
 UIImagePickerControllerで選択されなかったとき
 --------------------------------------------------------------------------------*/
- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
