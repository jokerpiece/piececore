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
    if (self.pageCode.length < 1) {
        self.pageCode = [PieceCoreConfig pageCodeData].newsTitle;
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
    [self setNewsView];
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [NewsRecipient alloc];
}

-(void)setNewsView
{
    //subview削除
    for(UIView *view in [self.view subviews]){
        [view removeFromSuperview];
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.05,
                                                               NavigationHight,
                                                               self.viewSize.width - self.viewSize.width*0.05,
                                                               self.viewSize.height*0.1)];
    UILabel *title_back = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                    NavigationHight,
                                                                    self.viewSize.width,
                                                                    self.viewSize.height*0.1)];
    title.numberOfLines = 0;
    title.text = self.newsRecipient.title;
    title_back.backgroundColor = [UIColor colorWithRed:0.86 green:0.86 blue:0.86 alpha:1.0];
    title.font = [UIFont fontWithName:@"GeezaPro" size:18];
    
    //news_Image生成
    UIImageView *newsIv = [[UIImageView alloc]init];
    
    int img_viewSize_width;
    int img_viewSize_height;
    
    
    if (![Common isNotEmptyString:self.newsRecipient.image_url ]) {
        img_viewSize_width = self.viewSize.width*0.05;
        img_viewSize_height = NavigationHight + self.viewSize.height*0.1 + 15;
    } else {
        
        NSURL *imageURL = [NSURL URLWithString:self.newsRecipient.image_url];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *newsImg = [UIImage imageWithData:imageData];
        
        //高さの比率を求める
        float hiritu = newsImg.size.height/newsImg.size.width;
        
        if (!isnan(hiritu)) {
            newsIv.frame = CGRectMake(self.viewSize.width*0.05,
                                      self.viewSize.height*0.23,
                                      self.viewSize.width*0.9,
                                      self.viewSize.width*0.9*hiritu
                                      );
            //        newsIv.backgroundColor = [UIColor flatYellowColor];
            
            
            newsIv.image = newsImg;
            newsIv.contentMode = UIViewContentModeScaleAspectFit;
            
            img_viewSize_width = self.viewSize.width*0.05;
            img_viewSize_height = self.viewSize.width*0.9*hiritu + self.viewSize.height*0.23 + 10;
        } else {
            img_viewSize_width = self.viewSize.width*0.05;
            img_viewSize_height = NavigationHight + self.viewSize.height*0.1 + 15;
        }
        
        
    }
    
    // news_text生成
    UILabel *textLbl = [[UILabel alloc]init];
    textLbl.text = self.newsRecipient.text;
    
    CGFloat custamLetterSpacing = 2.0f;
    UIFont *font = [UIFont fontWithName:@"GeezaPro" size:16];
    
    NSDictionary *attributes =@{NSFontAttributeName:font,
                                [NSNumber numberWithFloat:custamLetterSpacing]:NSKernAttributeName};
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:textLbl.text attributes:attributes];
    textLbl.attributedText = attributedText;
    
    CGSize textSize = [textLbl.text
                       boundingRectWithSize:CGSizeMake(self.viewSize.width - (img_viewSize_width * 2), CGFLOAT_MAX)
                       options:(NSStringDrawingUsesLineFragmentOrigin)
                       attributes:attributes
                       context:nil].size;
    
    if (![Common isNotEmptyString:textLbl.text]) {
        textSize = CGSizeZero;
    }
    
    //news_textの空白を消す
    textLbl.text = [textLbl.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    textLbl.frame = CGRectMake(img_viewSize_width,
                               img_viewSize_height,
                               textSize.width,
                               textSize.height
                               );
    
    //    textLbl.backgroundColor = [UIColor brownColor];
    textLbl.font = [UIFont fontWithName:@"GeezaPro" size:16];
    textLbl.numberOfLines = 0;
    
    
    int linkHeight = self.viewSize.height*0.07;
    int totalLinkHeight = 10;
    NSMutableArray *link_urls = [NSMutableArray array];
    //link_url生成
    if (![self.newsRecipient.link_list isEqual:[NSNull null]]){
        
        int i = 0;
        for (NSDictionary *dc in self.newsRecipient.link_list) {
            
            if ([Common isNotEmptyString:[dc objectForKey:@"link_title"]]) {
                UIButton *link_url = [[UIButton alloc]init];
                
                link_url.tag = i;
                link_url.frame = CGRectMake(img_viewSize_width,
                                            img_viewSize_height + textSize.height +totalLinkHeight,
                                            self.viewSize.width*0.9,
                                            linkHeight
                                            );
                
                
                NSMutableAttributedString *attrStr;
                attrStr = [[NSMutableAttributedString alloc] initWithString:[dc objectForKey:@"link_title"]];
                
                NSDictionary *attributes = @{
                                             NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                             NSForegroundColorAttributeName:[UIColor blueColor]
                                             };
                [attrStr addAttributes:attributes range:NSMakeRange(0, [attrStr length])];
                [link_url setAttributedTitle:attrStr forState:UIControlStateNormal];
                
                
                //                [link_url setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                //                [link_url setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
                
                link_url.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [link_url addTarget:self
                             action:@selector(news_link_Tapped:)
                   forControlEvents:UIControlEventTouchUpInside];
                [link_url.titleLabel setFont:[UIFont fontWithName:@"GeezaPro" size:16]];
                [link_urls addObject:link_url];
                totalLinkHeight += linkHeight;
                
            }
            i++;
        }
    }
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0,
                                                       0,
                                                       screen.size.width,
                                                       img_viewSize_height + textSize.height + totalLinkHeight + TabbarHight)];
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    self.sv.contentSize = self.uv.bounds.size;
    
    [self.sv addSubview:self.uv];
    [self.view addSubview:self.sv];
    [self.uv addSubview:title_back];
    [self.uv addSubview:title];
    
    if ([Common isNotEmptyString:self.newsRecipient.image_url]) {
        [self.uv addSubview:newsIv];
    }
    
    if ([Common isNotEmptyString:self.newsRecipient.text]) {
        [self.uv addSubview:textLbl];
    }
    
    
    for(UIButton *btn in link_urls){
        [self.uv addSubview:btn];
    }
    
}

-(void)news_link_Tapped:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    NSDictionary *dc = [self.newsRecipient.link_list objectAtIndex:button.tag];
    NSString *urlStr = [dc objectForKey:@"link_url"];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    if ([Common isNotEmptyString:urlStr]) {
        if ([[url host]isEqualToString:UrlSchemeHostUploadYoutube] || [[url host]isEqualToString:UrlSchemeHostInputMessage] || [[url host]isEqualToString:UrlSchemeHostQuestion]) {
            [[UIApplication sharedApplication] openURL:url];
            
        } else {
            WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:urlStr];
            [self presentViewController:vc animated:YES completion:nil];
            
        }
    }
}

@end