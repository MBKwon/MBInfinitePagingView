//
//  DemoViewController.m
//  MBInfinitePagingView
//
//  Created by MB KWON on 2013. 12. 29..
//  Copyright (c) 2013년 Semtle_men. All rights reserved.
//

#import "DemoViewController.h"
#import "MBInfinitePaingView.h"
#import "MBPagingViewItem.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    MBInfinitePaingView *pagingView = [[MBInfinitePaingView alloc] initWithFrame:CGRectMake(0, 100, 320, 200)];
    [pagingView setBackgroundColor:[UIColor lightGrayColor]];
    
    UIControl *testItem = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [testItem setBackgroundColor:[UIColor brownColor]];
    [testItem addTarget:self action:@selector(touchEventSelector) forControlEvents:UIControlEventTouchUpInside];
    
    [pagingView addItem:testItem];
    [self.view addSubview:pagingView];
    
    [pagingView scrollToDirection:MBPaingDirectionRight withTimeInterval:2.0 repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchEventSelector
{
    NSLog(@"scroll item is touched");
}

@end
