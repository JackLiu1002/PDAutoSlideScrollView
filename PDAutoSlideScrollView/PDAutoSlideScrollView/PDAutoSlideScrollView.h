//
//  PDAutoScrollView.h
//  PDAutoSlideScrollView
//
//  Created by Jack on 16/6/9.
//  Copyright © 2016年 jpanda. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AutoScrollViewSelectionHandle)(NSInteger selectedIndex);

@interface PDAutoSlideScrollView : UIView

@property (nonatomic,strong)NSArray<UIImage *> *dataSource;
@property (nonatomic, copy)AutoScrollViewSelectionHandle selectionHandle;

@end
