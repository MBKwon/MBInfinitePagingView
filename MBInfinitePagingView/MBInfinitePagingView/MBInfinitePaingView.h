//
//  MBInfinitePaingView.h
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 29..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum MBPaingDirection {
    MBPaingDirectionLeft = -1,
    MBPaingDirectionRight = 1
} MBPaingDirection;

@class MBPagingViewItem;

@interface MBInfinitePaingView : UIView


@property (assign, nonatomic) BOOL onTouch;
@property (assign, nonatomic) MBPaingDirection currentDirection;

@property (assign, nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger pagingLenth;
@property (strong, nonatomic) NSMutableArray *scrollItemArray;


@property (strong, nonatomic) MBPagingViewItem *leftItem;
@property (strong, nonatomic) MBPagingViewItem *rightItem;

-(void)prepareForScrolling;
-(void)scrollToDirection:(MBPaingDirection)direction;
-(void)scrollToDirection:(MBPaingDirection)direction withTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)yesOrNo;
-(void)addItem:(UIView *)item;
-(void)addItemsWithArray:(NSArray *)itemArray;
-(void)removeItem:(UIView *)item;
-(void)removeAllItems;

@end
