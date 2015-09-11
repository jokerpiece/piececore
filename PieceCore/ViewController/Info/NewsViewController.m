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
    self.textTv.text = self.newsRecipient.text;
    [self set_NewsViewController_item];
    NSLog(@"%@", self.titleLbl.text);
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [NewsRecipient alloc];
}

-(void)set_NewsViewController_item
{
    //subview削除
    for(UIView *view in [self.view subviews]){
        [view removeFromSuperview];
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.05,
                                                               self.viewSize.height*0.11,
                                                               self.viewSize.width,
                                                               self.viewSize.height*0.1)];
    UILabel *title_back = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    self.viewSize.height*0.11,
                                                                    self.viewSize.width,
                                                                    self.viewSize.height*0.1)];
    title.text = self.newsRecipient.title;
    title_back.backgroundColor = [UIColor grayColor];
    //title.backgroundColor = [UIColor colorWithRed:1 green:0.749 blue:0.239 alpha:0.5];
    title.font = [UIFont fontWithName:@"GeezaPro" size:22];
    
    //news_Image生成
    UIImageView *news_Image = [[UIImageView alloc]init];
    NSString *str = @"";
    int img_viewSize_width;
    int img_viewSize_height;
    if([self.newsRecipient.image_url isEqualToString:str]){
        img_viewSize_width = self.viewSize.width*0.05;
        img_viewSize_height = self.viewSize.height*0.3;
    }else{
        news_Image.frame = CGRectMake(self.viewSize.width*0.05,
                                      self.viewSize.height*0.23,
                                      self.viewSize.width*0.9,
                                      self.viewSize.height*0.45
                                                            );
        //news_Image.backgroundColor = [UIColor flatYellowColor];
        NSURL *imageURL = [NSURL URLWithString:self.newsRecipient.image_url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *news_img = [UIImage imageWithData:imageData];
        news_Image.image = news_img;
        news_Image.contentMode = UIViewContentModeScaleAspectFit;
        //[self.uv addSubview:news_Image];
        img_viewSize_width = self.viewSize.width*0.05;
        img_viewSize_height = self.viewSize.height*0.7;

    }

    // news_text生成
    UILabel *news_text = [[UILabel alloc]init];
    news_text.backgroundColor = [UIColor colorWithRed:1 green:0.749 blue:0.239 alpha:0.01];
    news_text.text = self.newsRecipient.text;
    NSLog(@"%@",self.newsRecipient.text);
    CGFloat custamLetterSpacing = 2.0f;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:news_text.text];
    [attributedText addAttribute:NSKernAttributeName
                           value:[NSNumber numberWithFloat:custamLetterSpacing]
                           range:NSMakeRange(0, attributedText.length)];
    news_text.attributedText = attributedText;
    int characters_number = 18;
    float line_size = news_text.text.length / characters_number;
    if(line_size == 0){
        line_size = 1.5;
    }
    float line = line_size * 0.062;
    
    news_text.numberOfLines = line_size+100;
    
    //news_textの空白を消す
    news_text.text = [news_text.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    news_text.frame = CGRectMake(img_viewSize_width,
                                 img_viewSize_height,
                                 img_viewSize_width+(self.viewSize.width*0.85),
                                 (img_viewSize_height*line) //+ (self.viewSize.height*0.7)
                                 );
    NSLog(@"word:%d, line:%lf", news_text.text.length, line_size);
    NSLog(@"%@", news_text.text);
    
    //news_text.backgroundColor = [UIColor brownColor];
    news_text.font = [UIFont fontWithName:@"GeezaPro" size:16];
    img_viewSize_height = (img_viewSize_height*line) + (self.viewSize.height*0.7);
    //[self.uv addSubview:news_text];
  
    //link_url生成
    if([self.newsRecipient.link_list isEqual:[NSNull null]]){
    }else{
        for (NSDictionary *d in self.newsRecipient.link_list) {
            NSLog(@"title:%@",[d objectForKey:@"link_title"]);
            NSLog(@"link:%@",[d objectForKey:@"link_url"]);
            if (self.link_title == nil && self.link_url == nil){
                self.link_title = [d objectForKey:@"link_title"];
                self.link_url = [d objectForKey:@"link_url"];
            }else if(self.link_title_2 == nil && self.link_url_2 == nil){
                self.link_title_2 = [d objectForKey:@"link_title"];
                self.link_url_2 = [d objectForKey:@"link_url"];
            }else if(self.link_title_3 == nil && self.link_url_3 == nil){
                self.link_title_3 = [d objectForKey:@"link_title"];
                self.link_url_3 = [d objectForKey:@"link_url"];
            }
        }
    }

    UIButton *link_url_1 = [[UIButton alloc]init];
    
    if([self.newsRecipient.image_url isEqualToString:str]){
        link_url_1.frame = CGRectMake(img_viewSize_width,
                                      img_viewSize_height, //+ (self.viewSize.height*0.7),
                                      self.viewSize.width*0.9,
                                      self.viewSize.height*0.07
                                      );
    }else{
        link_url_1.frame = CGRectMake(img_viewSize_width,
                                      img_viewSize_height,
                                      self.viewSize.width*0.9,
                                      self.viewSize.height*0.07
                                      );

    }

    [link_url_1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [link_url_1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [link_url_1 setTitle:self.link_title
                forState:UIControlStateNormal];
    [link_url_1 addTarget:self
                   action:@selector(news_link_Tapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [link_url_1.titleLabel setFont:[UIFont fontWithName:@"GeezaPro" size:16]];
    //img_viewSize_height = (img_viewSize_height*line) + (self.viewSize.height*0.7);
    //link_url_1.backgroundColor = [UIColor whiteColor];
    link_url_1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    
    UIButton *link_url_2 = [[UIButton alloc]init];
    link_url_2.frame = CGRectMake(img_viewSize_width,                                                                        img_viewSize_height + (self.viewSize.height*0.07),
                                self.viewSize.width*0.9,
                            self.viewSize.height*0.07
                                );
    [link_url_2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [link_url_2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [link_url_2 setTitle:self.link_title_2
                forState:UIControlStateNormal];
    [link_url_2 addTarget:self
                   action:@selector(news_link_2_Tapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [link_url_2.titleLabel setFont:[UIFont fontWithName:@"GeezaPro" size:16]];
    //img_viewSize_height = (img_viewSize_height*line) + (self.viewSize.height*0.7);
    //link_url_2.backgroundColor = [UIColor redColor];
    link_url_2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //[self.uv addSubview:link_url_2];
    
    UIButton *link_url_3 = [[UIButton alloc]init];
    link_url_3.frame = CGRectMake(img_viewSize_width,                                                                        img_viewSize_height + (self.viewSize.height*0.14),
                                  self.viewSize.width*0.9,
                                  self.viewSize.height*0.07
                                  );
    
    [link_url_3 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [link_url_3 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [link_url_3 setTitle:self.link_title_3
                forState:UIControlStateNormal];
    [link_url_3 addTarget:self
                   action:@selector(news_link_3_Tapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [link_url_3.titleLabel setFont:[UIFont fontWithName:@"GeezaPro" size:16]];
    //link_url_3.backgroundColor = [UIColor grayColor];
    link_url_3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    NSLog(@"%f,%f", screen.size.width, screen.size.height);
    
    img_viewSize_height = img_viewSize_height + (self.viewSize.height*0.6);
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                       0,
                                                       screen.size.width,
                                                       img_viewSize_height)];
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.sv.contentSize = self.uv.bounds.size;
    self.sv.backgroundColor = [UIColor colorWithRed:1 green:0.749 blue:0.239 alpha:0.1];
    
    [self.sv addSubview:self.uv];
    [self.view addSubview:self.sv];
    [self.uv addSubview:title_back];
    [self.uv addSubview:title];
    //[self.uv addSubview:border];
    if([news_Image isEqual:str]){
    }else{
        [self.uv addSubview:news_Image];
    }
    [self.uv addSubview:news_text];
    [self.uv addSubview:link_url_1];
    [self.uv addSubview:link_url_2];
    [self.uv addSubview:link_url_3];
    
}

-(void)news_link_Tapped:(id)sender
{
    if (self.link_title == nil && self.link_url == nil) {
        
    }else{
        WebViewController *itemVc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:self.link_url];
        [self.navigationController pushViewController:itemVc animated:YES];
    }

}

-(void)news_link_2_Tapped:(id)sender
{
    if (self.link_title_2 == nil && self.link_url_3 == nil) {
    
    }else{
        WebViewController *itemVc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:self.link_url_2];
        [self.navigationController pushViewController:itemVc animated:YES];
    }
}

-(void)news_link_3_Tapped:(id)sender
{
    if(self.link_title_3 == nil && self.link_url_3 == nil){
        
    }else{
        WebViewController *itemVc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:self.link_url_3];
        [self.navigationController pushViewController:itemVc animated:YES];
    }
}


@end
