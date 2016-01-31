//
//  HistoryViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/20.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "HistoryViewController.h"
#import "HistoryTableViewCell.h"
#import "WebViewController.h"
#import "DeliverRecipient.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"HistoryViewController" owner:self options:nil];
}
- (void)viewDidLoadLogic
{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].historyTitle;
    }
    self.historyOrderDataList = [NSMutableArray array];
    UINib *nib = [UINib nibWithNibName:@"HistoryTableViewCell" bundle:nil];
    [self.table registerNib:nib forCellReuseIdentifier:@"Cell"];
    self.table.rowHeight = UITableViewAutomaticDimension;
    //[self syncAction];
    [self.historyOrderDataList addObject:[[HistoryOrderData alloc]initSeedData]];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HistoryOrderData *orderData = [self.historyOrderDataList objectAtIndex:section];
    UIView *containerView = [[UIView alloc] init];
    UILabel *lbl1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, self.viewSize.width, 20)];
    lbl1.font = [UIFont systemFontOfSize:14];
    lbl1.text = [NSString stringWithFormat:@"注文日 %@",orderData.orderDate];
    [containerView addSubview:lbl1];
    UILabel *lbl2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, self.viewSize.width, 20)];
    lbl2.font = [UIFont systemFontOfSize:14];
    lbl2.text = [NSString stringWithFormat:@"注文番号 %@",orderData.orderNum];
    [containerView addSubview:lbl2];
    return containerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    HistoryOrderData *orderData = [self.historyOrderDataList objectAtIndex:section];
    return [NSString stringWithFormat:@"注文日 %@",orderData.orderDate];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    HistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    DLog(@"%ld",(long)indexPath.row);
    HistoryOrderData *historyOrderData = [self.historyOrderDataList objectAtIndex:indexPath.section];
    HistoryItemData *detailData = [historyOrderData.historyItemList objectAtIndex:indexPath.row];
    
    cell.itemNamelbl.text = detailData.item_name;
        
    if ([Common isNotEmptyString:detailData.img_url]) {
        NSURL *imageURL = [NSURL URLWithString:[detailData.img_url stringByAddingPercentEscapesUsingEncoding:
                                                    NSUTF8StringEncoding]];
            
        [cell.itemIv setImageWithURL:imageURL placeholderImage:nil options:SDWebImageCacheMemoryOnly usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
        
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.historyOrderDataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 74;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HistoryOrderData *orderData = [self.historyOrderDataList objectAtIndex:section];
    DLog(@"履歴数：%lu",(unsigned long)orderData.historyItemList.count);
    return orderData.historyItemList.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        self.selectRow = (int)indexPath.row;
        HistoryOrderData *historyOrderData = [self.historyOrderDataList objectAtIndex:indexPath.section];
        HistoryItemData *data = [historyOrderData.historyItemList objectAtIndex:indexPath.row];
    
        NSString *url = @"";
        if (data.deliverCampany == yamato) {
            url = [NSString stringWithFormat:@"%@%@",UrlYamatoDeliver,data.deliverNum];
        } else if(data.deliverCampany == sagawa){
            url = [NSString stringWithFormat:@"%@%@",UrlSagawaDeliver,data.deliverNum];
        } else if(data.deliverCampany == yubin){
            url = [NSString stringWithFormat:@"%@%@",UrlYubinDeliver,data.deliverNum];
        }
//        WebViewController *webVc = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil url:url];
//        webVc.title = @"配送状況";
//        [self.navigationController pushViewController:webVc animated:YES];
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:url];
        vc.title =@"配送状況";
        [self presentViewController:vc animated:YES completion:nil];
    }
    
}
-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKey:@"uuid"];
    [conecter sendActionSendId:SendIdDeliverList param:param];
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [DeliverRecipient alloc];
}

-(void)setDataWithRecipient:(DeliverRecipient *)recipient sendId:(NSString *)sendId{
    
    DeliverRecipient *deliverRecipient = recipient;
    self.historyOrderDataList = deliverRecipient.historyOrderlist;
    [self.table reloadData];
}
- (IBAction)toDeliveryAction:(id)sender {
}
@end
