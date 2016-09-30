//
//  CalendarViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2016/09/29.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "CalendarViewController.h"
#import "DayCell.h"
#import "VReserveViewController.h"

@implementation NSDate (Extension)

/**
 *  Return the date one month before the receiver.
 *
 *  @return  date
 */
- (NSDate *)monthAgoDate
{
    NSInteger addValue = -1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

/**
 *  Return the date one month after the receiver.
 *
 *  @return  date
 */
- (NSDate *)monthLaterDate
{
    NSInteger addValue = 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = addValue;
    return [calendar dateByAddingComponents:dateComponents toDate:self options:0];
}

@end


static NSUInteger const DaysPerWeek = 7;

static CGFloat const CellMargin = 2.0f;

@interface CalendarViewController ()

/**
 *  Selected date displayed by the calendar
 */
@property (nonatomic, strong) NSDate *selectedDate;

@end

@implementation CalendarViewController

#pragma mark - LifeCycle methods

- (void)viewDidLoadLogic
{
    UIBarButtonItem *btn1 = [[UIBarButtonItem alloc]
                            initWithTitle:@"Prev"
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(didTapPrevButton:)];
    
    // ナビゲーションバーの左側に追加する。
    self.navigationItem.leftBarButtonItem = btn1;
    
    UIBarButtonItem *btn2 = [[UIBarButtonItem alloc]
                            initWithTitle:@"Next"
                            style:UIBarButtonItemStylePlain
                            target:self
                            action:@selector(didTapNextButton:)];
    
    // ナビゲーションバーの左側に追加する。
    self.navigationItem.rightBarButtonItem = btn2;
    
    
    
    self.selectedDate = [NSDate date];
        UINib *nibFirst = [UINib nibWithNibName:@"DayCell" bundle:nil];
    [self.colectionView registerNib:nibFirst forCellWithReuseIdentifier:@"DayCell"];
    
    [self syncAction];
    [self.colectionView reloadData];
}


#pragma mark - Action methods

- (IBAction)didTapPrevButton:(id)sender
{
    self.selectedDate = [self.selectedDate monthAgoDate];
    
    [self.colectionView reloadData];
}

- (IBAction)didTapNextButton:(id)sender
{
    self.selectedDate = [self.selectedDate monthLaterDate];
    
    [self.colectionView reloadData];
}

#pragma mark - private methods

- (void)setSelectedDate:(NSDate *)selectedDate
{
    _selectedDate = selectedDate;
    
    // update title text
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy/M";
    self.title = [formatter stringFromDate:selectedDate];
}

/**
 *  Return First date of the month
 *
 *  @return date
 */
- (NSDate *)firstDateOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                                                   fromDate:self.selectedDate];
    components.day = 1;
    
    NSDate *firstDateMonth = [[NSCalendar currentCalendar] dateFromComponents:components];
    
    return firstDateMonth;
}

/**
 *  return date for specified indexPath
 *
 *  @param indexPath cell's indexPath
 *
 *  @return date
 */
- (NSDate *)dateForCellAtIndexPath:(NSIndexPath *)indexPath
{
    // calculate the ordinal number of first day
    NSInteger ordinalityOfFirstDay = [[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay
                                                                             inUnit:NSCalendarUnitWeekOfMonth
                                                                            forDate:self.firstDateOfMonth];
    
    // calculate the difference between "day number of cell at indexPath" and "day number of first day"
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.day = indexPath.item - (ordinalityOfFirstDay - 1);
    
    NSDate *date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                                 toDate:self.firstDateOfMonth
                                                                options:0];
    return date;
}

#pragma mark - UICollectionViewDataSource methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    // calculate number of weeks
    NSRange rangeOfWeeks = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitWeekOfMonth
                                                              inUnit:NSCalendarUnitMonth
                                                             forDate:self.firstDateOfMonth];
    NSUInteger numberOfWeeks = rangeOfWeeks.length;
    NSInteger numberOfItems = numberOfWeeks * DaysPerWeek;
    
    return numberOfItems;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayCell"
//                                                              forIndexPath:indexPath];
    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayCell" forIndexPath:indexPath];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"d";
    cell.label.text = [formatter stringFromDate:[self dateForCellAtIndexPath:indexPath]];
    
//    for (NSDictionary *dic in self.) {
//        <#statements#>
//    }
    
    
    //通常の背景
    UIView* backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
    cell.backgroundView = backgroundView;
    
    //選択時の背景
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBGView.backgroundColor = [UIColor colorWithRed:1.00 green:0.72 blue:0.30 alpha:1.0];
    cell.selectedBackgroundView = selectedBGView;
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numberOfMargin = 8;
    CGFloat width = floorf((collectionView.frame.size.width - CellMargin * numberOfMargin) / DaysPerWeek);
    CGFloat height = width * 1.5f;
    
    return CGSizeMake(width, height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(CellMargin, CellMargin, CellMargin, CellMargin);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return CellMargin;
}



-(void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"選択した %@",indexPath);
    DayCell *cell = (DayCell*)[collectionView cellForItemAtIndexPath:indexPath];
    self.dd = cell.label.text;

}

//-(void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"選択解除した %@",indexPath);
//    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:1.0f];
//}
- (IBAction)onReserv:(id)sender {
    NSDateComponents *comps = [self getNSDateComponentsWithDate:_selectedDate];
    
    VReserveViewController *vc = [[VReserveViewController alloc] initWithNibName:@"VReserveViewController" bundle:nil];
    vc.yyyy = [NSString stringWithFormat:@"%ld",(long)comps.year];
    vc.mm = [NSString stringWithFormat:@"%ld",(long)comps.month];
    vc.dd = self.dd;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)syncAction{
    self.isResponse = NO;
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    
    NSDateComponents *comps = [self getNSDateComponentsWithDate:_selectedDate];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[NSString stringWithFormat:@"%ld-%02ld",(long)comps.year,(long)comps.month] forKey:@"cal_date"];
    
    //[conecter sendActionSendId:SendIdGetCalendarEventList param:param];
    [conecter sendActionUrl:@"http://192.168.77.200/shinden/manager/html/xml/reserve/?Action=eventList" param:param];
}

-(NSDateComponents *)getNSDateComponentsWithDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps =
    [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|
     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
                fromDate:date];
    return comps;
}
-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [[BaseRecipient alloc]init];
}
-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    
//    if ([sendId isEqualToString:SendIdGetCalendarEventList]) {

        self.recipient = recipient;
        NSMutableArray *eventList = recipient.resultset[@"event_list"];
        NSLog(@"%lu",(unsigned long)eventList.count);
    [self.colectionView reloadData];
  //  }
}
@end
