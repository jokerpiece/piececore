//
//  ANZDropDownField.m
//  pieceSample
//
//  Created by OhnumaRina on 2016/05/17.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

//
//  ANZDropDownField.m
//  pieceSample
//
//  Created by OhnumaRina on 2016/05/16.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "DropDownField.h"
#import <QuartzCore/QuartzCore.h>

@interface DropDownField() {
    CGFloat _borderWidth;
    UITapGestureRecognizer* _singleTapGesture;
}

@property (nonatomic) UITableView* tableView;
@end

@implementation DropDownField

static NSString* _cellID = @"cell";

- (id)init
{
    if (self == [super init]) {
        [self prepare];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self prepare];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL result = [_singleTapGesture isEqual:gestureRecognizer];
    if (! self.dropList || [self.dropList count] == 0) {
        return !result;
    } else {
        return result;
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    if (self.heightOfListItem > 0) {
        return;
    }
    self.heightOfListItem = frame.size.height;
}


#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dropList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:_cellID];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_cellID];
        cell.contentView.backgroundColor = self.backgroundColor;
        cell.textLabel.textAlignment = self.textAlignment;
        cell.textLabel.font = self.font;
        cell.textLabel.textColor = self.textColor;
    }
    
    if (self.fontOfListItem) {
        cell.textLabel.font = self.fontOfListItem;
    }
    
    cell.textLabel.text = self.dropList[indexPath.item];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.heightOfListItem;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self hideDropDownListWithUpdateText:self.dropList[indexPath.item]];
}

#pragma mark - methods
- (void)prepare
{
    _borderWidth = .5f;
    
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.layer.borderWidth = _borderWidth;
    
    _displayNumOfRows = 5;
    _heightOfListItem = self.frame.size.height;
    _borderColorForList = [UIColor lightGrayColor];
    
    // ドロップダウンリスト開閉用に登録
    _singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self addGestureRecognizer:_singleTapGesture];
    
    
}

- (void)showDropDownList
{
    [self adjustTableView];     // 表示するドロップリストの高さ調整
    
    self.tableView.hidden = YES;
    
    [self.superview addSubview:self.tableView];
    [self.superview bringSubviewToFront:self];
    
    CGAffineTransform affine = CGAffineTransformMakeScale(1, 0);
    self.tableView.transform = affine;
    
    self.tableView.hidden = NO;
    [UIView animateWithDuration:.2f animations:^{
        self.tableView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideDropDownList
{
    [self hideDropDownListWithUpdateText:self.text];
}

- (void)hideDropDownListWithUpdateText:(NSString *)updateText;
{
    CGAffineTransform affine = CGAffineTransformScale(self.tableView.transform, 1, 0);
    self.adjustsFontSizeToFitWidth = YES;
    
    [UIView animateWithDuration:.2f animations:^{
        self.tableView.transform = affine;
    } completion:^(BOOL finished) {
        self.text = updateText;
        self.tableView.hidden = YES;
        self.tableView.transform = CGAffineTransformIdentity;
        [self.tableView removeFromSuperview];
        
        [self.delegate selectKikakuName:updateText];
    }];
}

- (void)adjustTableView
{
    NSUInteger numOfRows = 0;
    if (self.displayNumOfRows > [self.dropList count]) {
        numOfRows = [self.dropList count];
    } else {
        numOfRows = self.displayNumOfRows;
    }
    
    CGFloat heightTableVeiw = self.heightOfListItem * numOfRows;
    CGPoint startPoint = CGPointZero;
    CGFloat selfBottomLine = self.frame.origin.y + self.frame.size.height;
    
    // 下にドロップ表示できるか判定 (マージン30.f)
    if ((self.superview.frame.size.height - (selfBottomLine + 30.f)) > heightTableVeiw) {
        self.tableView.layer.anchorPoint = CGPointMake(.5f, 0);
        startPoint = CGPointMake(self.frame.origin.x, selfBottomLine - 1.f);
    } else {
        self.tableView.layer.anchorPoint = CGPointMake(.5f, 1);
        startPoint = CGPointMake(self.frame.origin.x, (self.frame.origin.y - heightTableVeiw) + 1.f);
    }
    
    self.tableView.layer.cornerRadius = self.layer.cornerRadius;
    self.tableView.frame = CGRectMake(startPoint.x,
                                      startPoint.y,
                                      self.frame.size.width,
                                      heightTableVeiw);
    
    self.tableView.layer.borderColor = self.borderColorForList.CGColor;
    self.tableView.backgroundColor = self.backgroundColor;
    
}

- (void)handleSingleTap:(id)sender
{
    if (self.tableView.superview) {
        [self hideDropDownList];
    } else {
        [self showDropDownList];
    }
}

@end
