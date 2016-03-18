//
//  ViewController.m
//  HotSearchViewDemo
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HotSearchView.h"

@interface ViewController () <HotSearchViewDelegate> {
    HotSearchView *_hotSearchView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *collectionTestData = [NSMutableArray arrayWithArray:@[@"三只蜻蜓托管sdfefasf", @"三管机构", @"三机构", @"管机构sfds", @"三只蜻", @"三只蜻管机构", @"三只蜻蜓托jlk;jkl;构", @"三只蜓托阿d芬ufrthf构", @"三只范德萨发的蜻蜓托", @"爱的是批发价哦派送点附近水平", @"12347894", @"4e8f4s6e8f4d5", @"hello", @"world"]];
    
    _hotSearchView = [[HotSearchView alloc] initWithFrame:CGRectMake(4, 44, [UIScreen mainScreen].applicationFrame.size.width - 8, 250)];
    _hotSearchView.dataArray = [NSMutableArray arrayWithArray:collectionTestData];
    _hotSearchView.delegate = self;
    [self.view addSubview:_hotSearchView];
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(100, CGRectGetMaxY(_hotSearchView.frame) + 10, 100, 100);
    addButton.layer.masksToBounds = YES;
    addButton.layer.borderColor = [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0].CGColor;
    addButton.layer.borderWidth = 0.5;
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addItemByHotSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeButton.frame = CGRectMake(CGRectGetMaxX(addButton.frame) + 30, CGRectGetMaxY(_hotSearchView.frame) + 10, 100, 100);
    removeButton.layer.masksToBounds = YES;
    removeButton.layer.borderWidth = addButton.layer.borderWidth;
    removeButton.layer.borderColor = addButton.layer.borderColor;
    [removeButton setTitle:@"删除" forState:UIControlStateNormal];
    [removeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeItemByHotSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addItemByHotSearch {
    [_hotSearchView insertString:@"托尔斯泰" inDataArrayAtIndex:0];
}

- (void)removeItemByHotSearch {
    [_hotSearchView removeStringAtIndex:0];
}

@end
