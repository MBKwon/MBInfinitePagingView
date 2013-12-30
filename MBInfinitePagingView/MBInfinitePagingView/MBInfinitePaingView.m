//
//  MBInfinitePaingView.m
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 29..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import "MBInfinitePaingView.h"
#import "MBPagingViewItem.h"

@implementation MBInfinitePaingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.pagingLenth = frame.size.width;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.scrollItemArray != nil) {
        [self initializeInfinitePaingView];
    }
}



#pragma mark - make a MBInfinitePaingView
-(void)initializeInfinitePaingView
{
    if ([self.scrollItemArray count] == 1) {
        UIView *firstObject = [self.scrollItemArray objectAtIndex:0];
        [self addSubview:firstObject];
        [self.scrollItemArray addObject:[self.scrollItemArray objectAtIndex:0]];
        
    } else {
        
        UIView *firstObject = [self.scrollItemArray objectAtIndex:0];
        [firstObject setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:firstObject];
    }
}



#pragma mark - scroll method
-(void)scrollToLeft
{
    [self scrollViewWithIndex:-1];
}

-(void)scrollToRight
{
    [self scrollViewWithIndex:1];
}

-(void)scrollViewWithIndex:(NSInteger)index
{
    
}



#pragma mark - manage items in MBInfinitePaingView (add)
-(void)addItem:(MBPagingViewItem *)item
{
    if (self.scrollItemArray == nil) {
        
        self.scrollItemArray = [NSMutableArray new];
    }
    
    MBPagingViewItem *pagingItem = [[MBPagingViewItem alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [item setCenter:CGPointMake(pagingItem.frame.size.width/2, pagingItem.frame.size.height/2)];
    [pagingItem addSubview:item];
    [self.scrollItemArray addObject:pagingItem];
}

-(void)addItemsWithArray:(NSArray *)itemArray
{
    if (self.scrollItemArray == nil) {
        
        self.scrollItemArray = [NSMutableArray new];
    }
    
    for (MBPagingViewItem *item in itemArray) {
        if ([item isKindOfClass:[MBPagingViewItem class]] != NO) {
            NSLog(@"ERROR : item that isn't a subclass of MBPagingViewItem is in a array");
            continue;
        } else {
            [self addItem:item];
        }
    }
}



#pragma mark - manage items in MBInfinitePaingView (remove)
-(void)removeItem:(MBPagingViewItem *)item
{
    if (self.scrollItemArray == nil) {
        return;
    }
    
    [self.scrollItemArray removeObject:item];
}

-(void)removeAllItems
{
    if (self.scrollItemArray == nil) {
        return;
    }
    
    [self.scrollItemArray removeAllObjects];
}

@end
