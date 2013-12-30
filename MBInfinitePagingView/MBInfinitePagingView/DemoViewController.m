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
    
    UIView *testItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [testItem setBackgroundColor:[UIColor brownColor]];
    
    [pagingView addItem:testItem];
    
    testItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [testItem setBackgroundColor:[UIColor brownColor]];
    
    [pagingView addItem:testItem];
    
    testItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [testItem setBackgroundColor:[UIColor brownColor]];
    
    [pagingView addItem:testItem];
    [self.view addSubview:pagingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
