//
//  ITViewItem.h
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITViewItem : UIView
@property (assign, nonatomic, getter = isSelected) BOOL selected;
-(void)updateViewWithItemInfo:(NSDictionary *)info;
@end
