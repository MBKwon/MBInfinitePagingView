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
    self.currentIndex = 0;
    if ([self.scrollItemArray count] == 1) {
        
        MBPagingViewItem *firstObject = [self.scrollItemArray objectAtIndex:self.currentIndex];
        
        [self.scrollItemArray addObject:[firstObject copy]];
        [self.scrollItemArray addObject:[firstObject copy]];
        
        
        [firstObject setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:firstObject];
        
    } else if ([self.scrollItemArray count] == 2) {
        
        MBPagingViewItem *firstObject = [self.scrollItemArray objectAtIndex:self.currentIndex];
        MBPagingViewItem *secondObject = [self.scrollItemArray objectAtIndex:self.currentIndex+1];
        
        [self.scrollItemArray addObject:[firstObject copy]];
        [self.scrollItemArray addObject:[secondObject copy]];
        
        
        [firstObject setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self addSubview:firstObject];
        
    } else if ([self.scrollItemArray count] > 2) {
        
        MBPagingViewItem *firstObject = [self.scrollItemArray objectAtIndex:self.currentIndex];
        [firstObject setCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)];
        [self addSubview:firstObject];
    }
}


#pragma mark - scroll method

-(void)scrollToDirection:(MBPaingDirection)direction
{
    if (direction <= 1 && direction >= -1) {
        
        [self scrollToDirection:direction withTimeInterval:1.0 repeats:NO];
    } else {
        
        [self scrollToDirection:self.currentDirection withTimeInterval:1.0 repeats:NO];
    }
}

-(void)scrollToDirection:(MBPaingDirection)direction withTimeInterval:(NSTimeInterval)timeInterval repeats:(BOOL)yesOrNo
{
    if (yesOrNo == NO) {
        
        [self prepareForScrolling];
        [self scrollViewWithIndex:direction];
        
    } else {
        
        if (direction <= 1 && direction >= -1) {
            
            self.currentDirection = direction;
        }
        self.repeatsTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(scrollToDirection:) userInfo:NO repeats:YES];
    }
}

-(void)scrollViewWithIndex:(NSInteger)index
{
    MBPagingViewItem *currentItem = [self.scrollItemArray objectAtIndex:self.currentIndex%self.scrollItemArray.count];
    
    
    if (index > 0) {
        
        
        [UIView animateWithDuration:0.4 animations:^{
            [currentItem setFrame:CGRectMake(-(self.frame.size.width), 0, self.frame.size.width, self.frame.size.height)];
            [self.rightItem setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }];
        
    } else if (index < 0) {
        
        [UIView animateWithDuration:0.4 animations:^{
            [currentItem setFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [self.leftItem setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        }];
        
    } else {
        
        [UIView animateWithDuration:0.4 animations:^{
            [currentItem setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            [self.leftItem setFrame:CGRectMake(-(self.frame.size.width), 0, self.frame.size.width, self.frame.size.height)];
            [self.rightItem setFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        }];
    }
    
    self.leftItem = nil;
    self.rightItem = nil;
    
    self.currentIndex = self.currentIndex+index;
}

-(void)prepareForScrolling
{
    NSInteger leftIndex = ((self.currentIndex+self.scrollItemArray.count)-1)%self.scrollItemArray.count;
    NSInteger rightIndex = (self.currentIndex+1)%self.scrollItemArray.count;
    
    self.leftItem = [self.scrollItemArray objectAtIndex:leftIndex];
    
    [self.leftItem setFrame:CGRectMake(-(self.frame.size.width), 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.leftItem];
    
    self.rightItem = [self.scrollItemArray objectAtIndex:rightIndex];
    [self.rightItem setFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:self.rightItem];
}



#pragma mark - manage items in MBInfinitePaingView (add)
-(void)addItem:(UIView *)item
{
    if (self.scrollItemArray == nil) {
        
        self.scrollItemArray = [NSMutableArray new];
    }
    
    MBPagingViewItem *pagingItem = [[MBPagingViewItem alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [item setCenter:CGPointMake(pagingItem.frame.size.width/2, pagingItem.frame.size.height/2)];
    [pagingItem setBackgroundColor:[UIColor clearColor]];
    [pagingItem addSubview:item];
    [self.scrollItemArray addObject:pagingItem];
}

-(void)addItemsWithArray:(NSArray *)itemArray
{
    if (self.scrollItemArray == nil) {
        
        self.scrollItemArray = [NSMutableArray new];
    }
    
    for (UIView *item in itemArray) {
        if ([item isKindOfClass:[UIView class]] != NO) {
            NSLog(@"ERROR : item that isn't a subclass of MBPagingViewItem is in a array");
            continue;
        } else {
            [self addItem:item];
        }
    }
}



#pragma mark - manage items in MBInfinitePaingView (remove)
-(void)removeItem:(UIView *)item
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
