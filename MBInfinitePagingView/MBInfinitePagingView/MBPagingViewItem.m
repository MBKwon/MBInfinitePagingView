//
//  MBPagingViewItem.m
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 30..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import "MBPagingViewItem.h"
#import "MBInfinitePaingView.h"

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
        NSLog(@"%@", [[self.superview class] description]);
        [pagingView prepareForScrolling];
        self.onTouch = YES;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.onTouch == YES) {
        
        MBInfinitePaingView *pagingView = (MBInfinitePaingView *) self.superview;
        
        CGPoint touchLocation = [self getTouchLocation:touches];
        NSInteger leftCenter = pagingView.center.x/2;
        NSInteger rightCenter = pagingView.frame.size.width-leftCenter;
        
        
        if (touchLocation.x < leftCenter) {
            [pagingView scrollToDirection:MBPaingDirectionLeft];
        } else if (touchLocation.x > rightCenter) {
            [pagingView scrollToDirection:MBPaingDirectionRight];
        } else {
            CGPoint center = pagingView.center;
            center.y = self.center.y;
            
            [UIView animateWithDuration:0.5 animations:^{
                [self setCenter:center];
            }];
        }
        self.onTouch = NO;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.onTouch) {
        NSLog(@"on Touch");
        
        MBInfinitePaingView *pagingView = (MBInfinitePaingView *) self.superview;
        CGPoint touchLocation = [self getTouchLocation:touches];
        
        CGPoint leftItemLocation = touchLocation;
        leftItemLocation.x -= self.frame.size.width;
        
        CGPoint rightItemLocation = touchLocation;
        rightItemLocation.x += self.frame.size.width;
        
        [UIView animateWithDuration:0.1 animations:^{
            [self setCenter:touchLocation];
            [pagingView.leftItem setCenter:leftItemLocation];
            [pagingView.rightItem setCenter:rightItemLocation];
        }];
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
