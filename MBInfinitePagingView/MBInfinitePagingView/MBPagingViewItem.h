//
//  MBPagingViewItem.h
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 30..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBPagingViewItem : UIView <NSCopying>

@property (assign, nonatomic) BOOL onTouch;
@property (assign, nonatomic) CGPoint previousLocation;

@end
