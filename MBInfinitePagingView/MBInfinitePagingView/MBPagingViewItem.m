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
}
 */

-(void)copyWithPagingViewitem:(MBPagingViewItem *)item
{
    for (UIView *subView in item.subviews) {
        [self addSubview:subView];
    }
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
            [pagingView scrollToLeft];
        } else if (touchLocation.x > rightCenter) {
            [pagingView scrollToRight];
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
