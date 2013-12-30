//
//  MBPagingViewItem.m
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 30..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import "MBPagingViewItem.h"

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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.onTouch = YES;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.onTouch = NO;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.onTouch) {
        NSLog(@"on Touch");
        
        UITouch *touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInView:self.superview];
        touchLocation.y = self.center.y;
        
        [UIView animateWithDuration:0.1 animations:^{
            [self setCenter:touchLocation];
        }];
    }
}

@end
