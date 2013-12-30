//
//  MBInfinitePaingView.h
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 29..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBPagingViewItem;

@interface MBInfinitePaingView : UIView

@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger pagingLenth;
@property (strong, nonatomic) NSMutableArray *scrollItemArray;

@property (strong, nonatomic) MBPagingViewItem *leftItem;
@property (strong, nonatomic) MBPagingViewItem *rightItem;

-(void)prepareForScrolling;
-(void)scrollToLeft;
-(void)scrollToRight;

-(void)addItem:(UIView *)item;
-(void)addItemsWithArray:(NSArray *)itemArray;
-(void)removeItem:(UIView *)item;
-(void)removeAllItems;

@end
