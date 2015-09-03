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
    [self set_item];
    NSLog(@"%@", self.titleLbl.text);
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [NewsRecipient alloc];
}

-(void)set_item
{
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, self.viewSize.height * 1.4)];
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.sv.contentSize = self.uv.bounds.size;
    
    //subview削除
    for(UIView *view in [self.view subviews]){
        [view removeFromSuperview];
    }
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    NSLog(@"%f,%f", screen.size.width, screen.size.height);
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height * 1.4)];
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
   // [self.sv addSubview:self.uv];
    self.sv.contentSize = self.uv.bounds.size;
   // [self.view addSubview:self.sv];
    
    self.sv.backgroundColor = [UIColor colorWithRed:1 green:0.749 blue:0.239 alpha:0.1];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0, self.viewSize.height*0.11,
                                                               self.viewSize.width, self.viewSize.height*0.1)];
    title.text = self.newsRecipient.title;
    title.backgroundColor = [UIColor colorWithRed:1 green:0.749 blue:0.239 alpha:0.5];
    title.font = [UIFont fontWithName:@"GeezaPro" size:22];
    [self.uv addSubview:title];
    
    UILabel *border = [[UILabel alloc] initWithFrame: CGRectMake(self.viewSize.width*0, self.viewSize.height*0.21,
                                                                 self.viewSize.width,self.viewSize.height*0.008)];
    border.backgroundColor = [UIColor colorWithRed:1 green:0.749 blue:0.239 alpha:0.8];
    [self.uv addSubview:border];
    
    //news_Image生成
    UIImageView *news_Image = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewSize.width/5, self.viewSize.height*0.23,
                                                                            self.viewSize.width*0.6, self.viewSize.height*0.45)];
    news_Image.backgroundColor = [UIColor flatYellowColor];
    NSURL *imageURL = [NSURL URLWithString:self.newsRecipient.image_url];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *news_img = [UIImage imageWithData:imageData];
    news_Image.image = news_img;
    news_Image.contentMode = UIViewContentModeScaleAspectFit;
    [self.uv addSubview:news_Image];

   // news_text生成
    UITextView *news_text = [[UITextView alloc]init];
    //news_text.backgroundColor = [UIColor colorWithRed:1 green:0.749 blue:0.239 alpha:0.01];
    news_text.text = self.newsRecipient.text;
    NSLog(@"%@",self.newsRecipient.text);
    CGFloat custamLetterSpacing = 2.0f;
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:news_text.text];
    [attributedText addAttribute:NSKernAttributeName
                           value:[NSNumber numberWithFloat:custamLetterSpacing]
                           range:NSMakeRange(0, attributedText.length)];
    news_text.attributedText = attributedText;
    int characters_number = 18;
    float line = (news_text.text.length / characters_number) * 0.1;

    news_text.frame = CGRectMake(self.viewSize.width*0.07, self.viewSize.height*0.7,
                                 self.viewSize.width*0.87, self.viewSize.height*line);
    news_text.backgroundColor = [UIColor brownColor];
    news_text.font = [UIFont fontWithName:@"GeezaPro" size:16];
    news_text.editable = NO;
    [self.uv addSubview:news_text];
    
    //link_url生成
    for (NSDictionary *d in self.newsRecipient.link_list) {
        NSLog(@"title:%@",[d objectForKey:@"link_title"]);
        NSLog(@"link:%@",[d objectForKey:@"link_url"]);
        if (self.link_title_2 == nil && self.link_url_2 == nil){
            self.link_title_2 = [d objectForKey:@"link_title"];
            self.link_url_2 = [d objectForKey:@"link_url"];
        }else{
            self.link_title = [d objectForKey:@"link_title"];
            self.link_url = [d objectForKey:@"link_url"];
        }
        
    }

    UIButton *link_url = [[UIButton alloc]initWithFrame:CGRectMake(self.viewSize.width*0.07, (self.viewSize.height*0.7 + self.viewSize.height*line) + line + self.viewSize.height*0.03,
                                                                   self.viewSize.width*0.87, self.viewSize.height*0.07)];
    [link_url setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [link_url setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [link_url setTitle:self.link_title
                forState:UIControlStateNormal];
    [link_url addTarget:self
                   action:@selector(news_link_Tapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [link_url.titleLabel setFont:[UIFont fontWithName:@"GeezaPro" size:16]];
    [self.uv addSubview:link_url];
    
    UIButton *link_movie = [[UIButton alloc]initWithFrame:CGRectMake(self.viewSize.width*0.07, (self.viewSize.height*0.7 + self.viewSize.height*line) + line + self.viewSize.height*0.1,
                                                                     self.viewSize.width*0.87, self.viewSize.height*0.07)];
    [link_movie setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [link_url setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [link_movie setTitle:self.link_title_2
                forState:UIControlStateNormal];
    [link_movie addTarget:self
                   action:@selector(news_link_2_Tapped:)
         forControlEvents:UIControlEventTouchUpInside];
    [link_movie.titleLabel setFont:[UIFont fontWithName:@"GeezaPro" size:16]];
    [self.uv addSubview:link_movie];
    
    [self.sv addSubview:self.uv];
    [self.view addSubview:self.sv];
    
}

-(void)news_link_Tapped:(id)sender
{
    WebViewController *itemVc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:self.link_url];
    [self.navigationController pushViewController:itemVc animated:YES];

}

-(void)news_link_2_Tapped:(id)sender
{
    WebViewController *itemVc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:self.link_url_2];
    [self.navigationController pushViewController:itemVc animated:YES];

}



@end
