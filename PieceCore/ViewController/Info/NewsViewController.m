//
//  NewsViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "NewsViewController.h"
#import "CoreDelegate.h"

@interface NewsViewController ()

@end

@implementation NewsViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"NewsViewController" owner:self options:nil];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoadLogic
{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].newsTitle;
    }
    self.textTv.delegate = self;
}

- (BOOL) textViewShouldBeginEditing: (UITextView*) textView
{
    
    return NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self syncAction];
    [super viewWillAppear:animated];
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.news_id forKey:@"news_id"];
    [conecter sendActionSendId:SendIdNews param:param];
}

-(void)setDataWithRecipient:(NewsRecipient *)recipient sendId:(NSString *)sendId{
      self.newsRecipient = recipient;
      self.titleLbl.text = self.newsRecipient.title;
//    self.textTv.text = self.newsRecipient.text;
    [self set_item];
    NSLog(@"%@", self.titleLbl.text);
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [NewsRecipient alloc];
}

-(void)set_item
{
    //subview削除
    for(UIView *view in [self.view subviews]){
        [view removeFromSuperview];
    }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    NSLog(@"%f,%f", screen.size.width, screen.size.height);
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height * 1.4)];
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    [self.sv addSubview:self.uv];
    self.sv.contentSize = self.uv.bounds.size;
    [self.view addSubview:self.sv];
    
    UILabel *title = [[UILabel alloc] init];
    title.frame = CGRectMake(self.viewSize.width*0.1, self.viewSize.height*0.15, self.viewSize.width*0.8, self.viewSize.height*0.05);
    //title.backgroundColor = [UIColor blueColor];
    title.text = self.newsRecipient.title;
    title.font = [UIFont fontWithName:@"AppleGothic" size:21];
    [self.uv addSubview:title];
    
    
    UILabel *border = [[UILabel alloc] init];
    border.frame = CGRectMake(0, self.viewSize.height*0.2, self.viewSize.width, self.viewSize.height*0.008);
    border.backgroundColor = [UIColor orangeColor];
    [self.uv addSubview:border];
    
    //news_Image生成
    UIImageView *news_Image = [[UIImageView alloc] init];
    news_Image.frame = CGRectMake(self.viewSize.width/5, self.viewSize.height*0.23, self.viewSize.width*0.6, self.viewSize.height*0.45);
    news_Image.backgroundColor = [UIColor flatYellowColor];
    NSURL *imageURL = [NSURL URLWithString:@"http://192.168.77.200/piece_stab/img/detail1.jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *set_image = [UIImage imageWithData:imageData];
    news_Image.image = set_image;
    
    [self.uv addSubview:news_Image];

    //news_text生成
    UITextView *news_text = [[UITextView alloc]init];
    news_text.frame = CGRectMake(self.viewSize.width*0.07, self.viewSize.height*0.7, self.viewSize.width*0.87, self.viewSize.height*0.4);
    news_text.text = @"XX月XX日のイベントでXXさんが着ていたコスチュームはこちらです。下記リンクで販売店を開きます。";
    //news_text.backgroundColor = [UIColor brownColor];
    news_text.font = [UIFont fontWithName:@"AppleGothic" size:14];
    news_text.editable = NO;
    [self.uv addSubview:news_text];
    
    //link_url生成
    UIButton *link_url = [[UIButton alloc]init];
    link_url.frame = CGRectMake(self.viewSize.width*0.07, self.viewSize.height*1.1, self.viewSize.width*0.87, self.viewSize.height*0.07);
    [link_url setTitle:@"コスプレはこちらで購入できます！"
                forState:UIControlStateNormal];
    //link_url.backgroundColor = [UIColor redColor];
    [link_url addTarget:self
                   action:@selector(news_link_Tapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [link_url.titleLabel setFont:[UIFont fontWithName:@"AppleGothic" size:16]];
    [link_url setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.uv addSubview:link_url];
    
    UIButton *link_movie = [[UIButton alloc]init];
    link_movie.frame = CGRectMake(self.viewSize.width*0.07, self.viewSize.height*1.17, self.viewSize.width*0.87, self.viewSize.height*0.07);
    [link_movie setTitle:@"動画はこちら"
                forState:UIControlStateNormal];
    //link_movie.backgroundColor = [UIColor flatRedColor];
    [link_movie addTarget:self
                   action:@selector(news_link_2_Tapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [link_movie.titleLabel setFont:[UIFont fontWithName:@"AppleGothic" size:16]];
    [link_movie setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.uv addSubview:link_movie];
    
}

-(void)news_link_Tapped:(id)sender
{
    WebViewController *itemVc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:@"http://www.rubies.co.jp/"];
    [self.navigationController pushViewController:itemVc animated:YES];

}

-(void)news_link_2_Tapped:(id)sender
{
    WebViewController *itemVc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:@"https://www.google.co.jp/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0CB8QtwIwAGoVChMI5s_-8o_IxwIVhXumCh1J4Abq&url=http%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3D5DqNYJqqwQM&ei=kWneVabDO4X3mQXJwJvQDg&usg=AFQjCNGe_l1aDhFQTsNlBDLJO7b_Gn1y2w"];
    [self.navigationController pushViewController:itemVc animated:YES];

}


@end
