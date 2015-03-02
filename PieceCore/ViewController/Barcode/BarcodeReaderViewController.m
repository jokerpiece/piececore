//
//  BarcodeReaderViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/22.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BarcodeReaderViewController.h"

@interface BarcodeReaderViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *prevLayer;
@end

@implementation BarcodeReaderViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"BarcodeReaderViewController" owner:self options:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self barcodeCap];
    self.session = [[AVCaptureSession alloc] init];
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *device = nil;
    AVCaptureDevicePosition camera = AVCaptureDevicePositionBack; // Back or Front
    for (AVCaptureDevice *d in devices) {
        device = d;
        if (d.position == camera) {
            break;
        }
    }
    
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device
                                                                        error:&error];
    [self.session addInput:input];
    
    AVCaptureMetadataOutput *output = [AVCaptureMetadataOutput new];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [self.session addOutput:output];
    
    output.metadataObjectTypes = output.availableMetadataObjectTypes;
    
    DLog(@"%@", output.availableMetadataObjectTypes);
    DLog(@"%@", output.metadataObjectTypes);
    
    [self.session startRunning];
    
    self.prevLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.prevLayer.frame = CGRectMake(0, 0, 320, 514);
    self.prevLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:self.prevLayer];
    [self drowLine];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.isReaded = NO;
    [super viewWillAppear:animated];
}
-(void)drowLine{
    CGRect bounds = self.prevLayer.bounds;
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGFloat width = 300.0f;
    CGFloat height = 200.0f;
    CGFloat x = (bounds.size.width - width) / 2.0;
    CGFloat y = (bounds.size.height - height) / 2.0;
    
    CGRect rect = CGRectMake(x, y, width, height);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {
        0.0f, 0.0f, 0.0f, 1.0f,
        0.0f, 0.0f, 0.0f, 0.3f,
        0.0f, 0.0f, 0.0f, 0.3f,
        0.0f, 0.0f, 0.0f, 1.0f
    };
    CGFloat locations[] = {0.0f, 0.2f, 0.8f, 1.0f};
    size_t count = sizeof(components) / (sizeof(CGFloat) * 4);
    
    CGPoint startPoint = bounds.origin;
    CGPoint endPoint = bounds.origin;
    //    endPoint.x += bounds.size.width;
    endPoint.y += bounds.size.height;
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, count);
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(space);
    
    //    CGContextSetRGBFillColor(context, 0.0, 0.0, 0.0, 0.3);
    //    CGContextFillRect(context, bounds);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGContextFillRect(context, rect);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetRGBStrokeColor(context, 1.0, 0.3, 0.3, 1.0);
    CGContextSetLineWidth(context, 2.0);
    CGContextMoveToPoint(context, x + (width / 2.0), y + (height / 2.0) - 10.0);
    CGContextAddLineToPoint(context, x + (width / 2.0), y + (height / 2.0) + 10.0);
    CGContextMoveToPoint(context, x, y + (height / 2.0));
    CGContextAddLineToPoint(context, x + width, y + (height / 2.0));
    CGContextStrokePath(context);
    
    CGFloat cornerSize = 30.0;
    CGFloat cornerLineWidth = 5.0;
    CGFloat x1 = x + (cornerLineWidth / 2.0);
    CGFloat y1 = y + (cornerLineWidth / 2.0);
    CGFloat x2 = x + width - (cornerLineWidth / 2.0);
    CGFloat y2 = y + height - (cornerLineWidth / 2.0);
    
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, cornerLineWidth);
    CGContextMoveToPoint(context, x1, y1 + cornerSize);
    CGContextAddLineToPoint(context, x1, y1);
    CGContextAddLineToPoint(context, x1 + cornerSize, y1);
    CGContextMoveToPoint(context, x2, y1 + cornerSize);
    CGContextAddLineToPoint(context, x2, y1);
    CGContextAddLineToPoint(context, x2 - cornerSize, y1);
    CGContextMoveToPoint(context, x1, y2 - cornerSize);
    CGContextAddLineToPoint(context, x1, y2);
    CGContextAddLineToPoint(context, x1 + cornerSize, y2);
    CGContextMoveToPoint(context, x2, y2 - cornerSize);
    CGContextAddLineToPoint(context, x2, y2);
    CGContextAddLineToPoint(context, x2 - cornerSize, y2);
    CGContextStrokePath(context);
    
    NSString *label = @"バーコードを\n読み取ってください";
    [[UIColor whiteColor]set];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    style.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName : [UIColor whiteColor],
                                 NSFontAttributeName : [UIFont systemFontOfSize:16],
                                 NSParagraphStyleAttributeName : style
                                 };
    
    [label drawInRect:CGRectMake(0, 100, 320, 50) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    CALayer *layer = [CALayer layer];
    [layer setFrame:bounds];
    [layer setContents:(id)image.CGImage];
    
    [self.prevLayer addSublayer:layer];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    CGRect highlightViewRect = CGRectZero;
    AVMetadataMachineReadableCodeObject *barCodeObject;
    NSString *detectionString = nil;
    NSArray *barCodeTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code];
    for (AVMetadataObject *metadata in metadataObjects) {
        
        for (NSString *type in barCodeTypes) {
            if ([metadata.type isEqualToString:type]){
                barCodeObject = (AVMetadataMachineReadableCodeObject *)[self.prevLayer transformedMetadataObjectForMetadataObject:(AVMetadataMachineReadableCodeObject *)metadata];
                highlightViewRect = barCodeObject.bounds;
                detectionString = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
                break;
            }
        }
        
        
    }
    if (detectionString.length > 0 && !self.isReaded) {
        self.isReaded = YES;
        self.barcodeNum = detectionString;
        [self searchItem:detectionString];
    }
    
}


-(void)searchItem:(NSString *)detectionString{
    if ([PieceCoreConfig tabnumberShopping]) {
        // ① 2番目のタブのViewControllerを取得する
        UINavigationController *navigationC = self.tabBarController.viewControllers[[PieceCoreConfig tabnumberShopping].intValue];
        // ② 2番目のタブを選択済みにする
        self.tabBarController.selectedViewController = navigationC;
        // ③ UINavigationControllerに追加済みのViewを一旦取り除く
        [navigationC popToRootViewControllerAnimated:NO];
        // ④ SecondViewの画面遷移処理を呼び出す
        ItemListViewController *itemListVc = [[ItemListViewController alloc] initWithNibName:@"ItemListViewController" bundle:nil];
        itemListVc.searchType = barcode;
        itemListVc.code = detectionString;
        
        [navigationC pushViewController:itemListVc animated:YES];
    }
    
    
}
@end
