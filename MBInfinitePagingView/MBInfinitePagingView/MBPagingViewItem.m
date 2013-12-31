//
//  MBPagingViewItem.m
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 30..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import "MBPagingViewItem.h"
#import "MBInfinitePaingView.h"

#define INITIAL_LOCATION_VALUE -1000
#define INITIAL_LOCATION CGPointMake(-1000, -1000)

@implementation MBPagingViewItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(30, 30, 30, 30)];
 [testView setBackgroundColor:[UIColor redColor]];
 [self addSubview:testView];
 }
 */

-(id)copyWithZone:(NSZone *)zone
{
    MBPagingViewItem *object = [[MBPagingViewItem alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [object setBackgroundColor:[UIColor clearColor]];
    NSArray *copiedSubviews = [[NSArray alloc] initWithArray:[self.subviews copyWithZone:zone]];
    
    for (UIView *subview in copiedSubviews) {
        
        //this line is for Deep copy a view.
        UIView *copyOfView = (UIView *) [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:subview]];
        [object addSubview:copyOfView];
    }
    
    return object;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.onTouch == NO) {
        
        MBInfinitePaingView *pagingView = (MBInfinitePaingView *) self.superview;
        [pagingView setOnTouch:YES];
        
        NSLog(@"%@", [[self.superview class] description]);
        [pagingView prepareForScrolling];
        self.onTouch = YES;
        self.previousLocation = INITIAL_LOCATION;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.onTouch == YES) {
        
        MBInfinitePaingView *pagingView = (MBInfinitePaingView *) self.superview;
        [pagingView setOnTouch:NO];
        
        CGPoint touchLocation = self.center;
        NSInteger leftCenter = pagingView.center.x/2;
        NSInteger rightCenter = pagingView.frame.size.width-leftCenter;
        
        
        if (touchLocation.x < leftCenter) {
            [pagingView scrollToDirection:MBPaingDirectionRight];
        } else if (touchLocation.x > rightCenter) {
            [pagingView scrollToDirection:MBPaingDirectionLeft];
        } else {
            [pagingView scrollToDirection:MBPaingDirectionCenter];
        }
        self.onTouch = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.onTouch) {
        
        if (self.previousLocation.x != INITIAL_LOCATION_VALUE) {
            MBInfinitePaingView *pagingView = (MBInfinitePaingView *) self.superview;
            CGPoint touchLocation = [self getTouchLocation:touches];
            NSInteger movedLength = touchLocation.x - self.previousLocation.x;
            
            CGPoint centerItem = self.center;
            centerItem.x += movedLength;
            touchLocation.y = self.center.y;
            
            CGPoint leftItemLocation = self.center;
            leftItemLocation.x -= self.frame.size.width;
            leftItemLocation.x += movedLength;
            touchLocation.y = self.center.y;
            
            CGPoint rightItemLocation = self.center;
            rightItemLocation.x += self.frame.size.width;
            rightItemLocation.x += movedLength;
            touchLocation.y = self.center.y;
            
            [UIView animateWithDuration:0.1 animations:^{
                [self setCenter:centerItem];
                [pagingView.leftItem setCenter:leftItemLocation];
                [pagingView.rightItem setCenter:rightItemLocation];
            }];
        }
        
        self.previousLocation = [self getTouchLocation:touches];
    }
}

-(CGPoint)getTouchLocation:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.superview];
    touchLocation.y = self.center.y;
    
    return touchLocation;
}

@end
