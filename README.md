## Overview

![snapshot](https://github.com/JackLiu1002/PDAutoSlideScrollView/blob/master/PDAutoSlideScrollView/snapshot.gif)

## Usage

``` objc
    PDAutoSlideScrollView *autoScrollView = [[PDAutoSlideScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    autoScrollView.dataSource = @[[UIImage imageNamed:@"banner_0.jpeg"],[UIImage imageNamed:@"banner_1.jpeg"],[UIImage imageNamed:@"banner_2.jpeg"],[UIImage imageNamed:@"banner_3.jpeg"],[UIImage imageNamed:@"banner_4.jpeg"],[UIImage imageNamed:@"banner_5.jpeg"]];
    
    autoScrollView.selectionHandle = ^(NSInteger selectedIndex) {
        NSLog(@"selectedIndex:%li",selectedIndex);
    };
    [self.view addSubview:autoScrollView];
```

## Installation

Use cocoapods  

``` ruby
pod 'PDAutoSlideScrollView', '1.0.0'
```

## License

PDAutoSlideScrollView is released under the MIT license. See LICENSE for details.
