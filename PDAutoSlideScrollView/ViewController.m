//
//  ViewController.m
//  PDAutoSlideScrollView
//
//  Created by Jack on 16/6/9.
//  Copyright © 2016年 jpanda. All rights reserved.
//

#import "ViewController.h"
#import "PDAutoSlideScrollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
        
    PDAutoSlideScrollView *autoScrollView = [[PDAutoSlideScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    autoScrollView.dataSource = @[[UIImage imageNamed:@"banner_0.jpeg"],[UIImage imageNamed:@"banner_1.jpeg"],[UIImage imageNamed:@"banner_2.jpeg"],[UIImage imageNamed:@"banner_3.jpeg"],[UIImage imageNamed:@"banner_4.jpeg"],[UIImage imageNamed:@"banner_5.jpeg"]];
    
    autoScrollView.selectionHandle = ^(NSInteger selectedIndex) {
        NSLog(@"selectedIndex:%li",selectedIndex);
    };
    [self.view addSubview:autoScrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
