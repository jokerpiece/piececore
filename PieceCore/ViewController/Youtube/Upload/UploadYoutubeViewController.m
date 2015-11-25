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
    
    [self.scrView setContentSize:CGSizeMake(0, self.viewSize.height)];
    [self.scrView setContentOffset:CGPointMake(0, 100)];
}

-(void)textViewShouldEndEditing: (UITextView*)textView{
    [self.scrView setContentSize:CGSizeMake(0, 0)];
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
            NSLog(@"size is %f",[size floatValue]/(1024.0*1024.0)); //size is 43.703005
            NSData *data = [NSData dataWithContentsOfURL:urlAsset.URL];
            NSLog(@"length %f",[data length]/(1024.0*1024.0)); // data size is 43.703005
            [self sendPostYoutubeMovieWithToken:token VideoData:data];
        }
    }];
    
    
    
    /*
     //NSData
     ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
     
     [assetLibrary assetForURL:self.movieURL resultBlock:^(ALAsset *asset) {
     if (asset) {
     DLog(@"ほげほげ");
     } else {
     [assetLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
     
     if (group) {
     DLog(@"グループ：%@",group);
     [group setAssetsFilter:[ALAssetsFilter allVideos]];
     [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
     if (result == nil) {
     DLog(@"result nil");
     }
     DLog(@"%@",result.defaultRepresentation.url);
     if ([result.defaultRepresentation.url isEqual:self.movieURL]){
     
     // フォトストリームのALAsset取得成功
     *stop = YES;
     ALAssetRepresentation *rep = [result defaultRepresentation];
     Byte *buffer = (Byte*)malloc(rep.size);
     NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
     NSData *videoData = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
     
     
     NetworkConecter *conecter = [NetworkConecter alloc];
     conecter.delegate = self;
     NSMutableDictionary *param = [NSMutableDictionary dictionary];
     [param setValue:@"1" forKeyPath:@"order_num"];
     [param setValue:@"6AA5E044-E002-4193-A4DB-BE583C501CC4" forKeyPath:@"uuid"];
     
     NSMutableDictionary *headerParam = [NSMutableDictionary dictionary];
     
     //https://developers.google.com/youtube/v3/guides/using_resumable_upload_protocol?hl=ja_
     
     [headerParam setValue:token forKeyPath:@"authorization"];
     //[headerParam setValue:token forKeyPath:@"content-length"];
     [headerParam setValue:@"application/json; charset=UTF-8" forKeyPath:@"content-type"];
     //[headerParam setValue:token forKeyPath:@"x-upload-content-length"];
     [headerParam setValue:@"video/*" forKeyPath:@"X-Upload-Content-Type"];
     [param setObject:@"snippet" forKey:@"part"];
     
     
     [conecter uploadActionUrl:SendIdPostYoutubeMovie headerParam:headerParam
     param:param fileData:videoData pramName:@"file" fileName:[self.movieURL lastPathComponent] mineTipe:@"video/quicktime"];
     
     }
     }];
     }
     
     } failureBlock:^(NSError *error) {
     DLog(@"フォトストリームのALAsset取得失敗");
     }];
     }
     ALAssetRepresentation *rep = [asset defaultRepresentation];
     
     
     } failureBlock:^(NSError *err) {
     DLog(@"エラー%@",err.localizedDescription);
     }];
     
     */
    
    
    
}

//動画情報更新
//-(void)sendMovieUpdate:(NSString*)moveId{
//    NetworkConecter *conecter = [NetworkConecter alloc];
//    conecter.delegate = self;
//    
////    [param setObject:@"snippet"forKey:@"part"];
//    NSMutableDictionary *headerParam = [NSMutableDictionary dictionary];
//    
//    //https://developers.google.com/youtube/v3/guides/using_resumable_upload_protocol?hl=ja_
//    
//    [headerParam setValue:[NSString stringWithFormat:@"Bearer %@",self.update_token] forKeyPath:@"Authorization"];
//
////    NSMutableDictionary *param = [[NSMutableDictionary alloc]initWithDictionary:
////                                                                            @{@"id":moveId,
////                                                                              @"snippet":@{@"title":self.movieTitleTf.text,
////                                                                                           @"categoryId":@"22",
////                                                                                           @"description":self.movieTv.text},
////                                                                              @"status":@{@"privacyStatus":@"private",
////                                                                                            @"embeddable":@"true",
////                                                                                          @"license":@"youtube",
////                                                                                          @"publicStasViewable":@"true"}}];
//    
//    NSString *param = [NSString stringWithFormat:@"{'id':'%@','snippet':{'title':'%@','categoryId':'22','description':'%@'},'status':{'privacyStatus':'private','embeddable':'true','license':'youtube','publicStasViewable':'true'}}",moveId,self.movieTitleTf.text,self.movieTv.text];
//
////    NSData *parameter = [NSJSONSerialization dataWithJSONObject:param options:kNilOptions error:nil];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    for (id key in headerParam) { 
//        NSLog(@"Key:%@ Value:%@", key, [headerParam valueForKey:key]);
//        [manager.requestSerializer setValue:[headerParam valueForKey:key] forHTTPHeaderField:key];
//    }
//
//    [manager PUT:SendIdPostYoutubeMovieInfo
//       parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject)
//     {
//         [self uploadMovieInfo:moveId];
//     }
//          failure:^(AFHTTPRequestOperation *operation, NSError *error)
//     {
//         DLog(@"%@",error);
//         [super receiveError:error sendId:SendIdPostYoutubeMovie];
//     }];
//    
//}

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
        NSLog(@"PhotoLibraryが使えない");
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
        
        NSLog(@"動画の場所：%@",url.absoluteString);
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
