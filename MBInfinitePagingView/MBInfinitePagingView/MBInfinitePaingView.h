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

@property (assign, nonatomic) NSInteger viewIndex;
@property (assign, nonatomic) NSInteger pagingLenth;
@property (strong, nonatomic) NSMutableArray *scrollItemArray;

-(void)addItem:(MBPagingViewItem *)item;
-(void)addItemsWithArray:(NSArray *)itemArray;
-(void)removeItem:(MBPagingViewItem *)item;
-(void)removeAllItems;

@end
