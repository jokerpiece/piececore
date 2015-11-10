//
//  MovieUploadViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/06.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "MovieUploadViewController.h"

@import Photos;
#import <AVFoundation/AVFoundation.h>

@interface MovieUploadViewController ()
@property (nonatomic) NSURL *movieURL;


@end

@implementation MovieUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(endTextEdit:)];
    [self.view addGestureRecognizer:ges];
    
}
-(void)endTextEdit:(id)sender{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)movieSelectAction:(id)sender {
    [self chooseMovie];
}

//アップロード１
- (IBAction)movieUploadAction:(id)sender {
    if (self.movieURL == nil) {
        return;
    }
    [self sendGetYoutubeWithToken];
}
-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [BaseRecipient alloc];
}


//認証
//-(void)sendGetYoutubeAuthSub{
//    NetworkConecter *conecter = [NetworkConecter alloc];
//    conecter.delegate = self;
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"1" forKeyPath:@"order_num"];
//    [param setValue:@"6AA5E044-E002-4193-A4DB-BE583C501CC4" forKeyPath:@"uuid"];
//    [conecter AuthActionUrl:@"https://accounts.google.com/o/oauth2/auth?client_id=367759414941-n88igj3uocu5ds6qj30r42c4ssomjvnu.apps.googleusercontent.com&redirect_uri=urn:ietf:wg:oauth:2.0:oob&scope=https://www.googleapis.com/auth/youtube&response_type=code&access_type=offline"
//                headerParam:(NSMutableDictionary*)headerParam
//                      param:(NSMutableDictionary*)paramparam:param];
//}

//アップロード２
-(void)sendGetYoutubeWithToken{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"1" forKeyPath:@"order_num"];
    [param setValue:@"6AA5E044-E002-4193-A4DB-BE583C501CC4" forKeyPath:@"uuid"];
    [conecter sendActionSendId:SendIdGetYoutubeToken param:param];
}

//アップロード４
-(void)sendPostYoutubeMovieWithToken:(NSString *)token VideoData:(NSData *)videoData{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    [param setObject:@"snippet"forKey:@"part"];
//    [param setObject:@"test" forKey:@"title"];
//    [param setObject:@"test" forKey:@"description"];
//    [param setObject:@"22" forKey:@"categoryId"];
//    [param setObject:@"private" forKey:@"privacyStatus"];
    NSMutableDictionary *headerParam = [NSMutableDictionary dictionary];
    
    //https://developers.google.com/youtube/v3/guides/using_resumable_upload_protocol?hl=ja_
    
//    [headerParam setValue:token forKeyPath:@"authorization"];
    [headerParam setValue:[NSString stringWithFormat:@"Bearer %@",token] forKeyPath:@"Authorization"];
    //[headerParam setValue:token forKeyPath:@"content-length"];
    [headerParam setValue:@"application/otet-stream" forKeyPath:@"Content-Type"];
    //[headerParam setValue:token forKeyPath:@"x-upload-content-length"];
//    [headerParam setValue:@"video/*" forKeyPath:@"X-Upload-Content-Type"];

    
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
-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{

    DLog(@"%@",recipient.resultset);
    if([sendId isEqualToString:SendIdGetYoutubeToken]){
        [self getYoutubeMovieWithToken:recipient.resultset[@"token"]];
    }else if([sendId isEqualToString:SendIdPostYoutubeMovie]){
        [self showAlert:@"アップロード" message:@"アップロード完了"];
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
