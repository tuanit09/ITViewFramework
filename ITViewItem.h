//
//  ITViewItem.h
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ITViewItemDelegate <NSObject>
@optional
-(void)ITViewItemPressed:(id)viewItem;
@end

@interface ITViewItem : UIView
@property (weak, nonatomic) id<ITViewItemDelegate>delegate;
@property (assign, nonatomic, getter = isSelected) BOOL selected;
-(void)updateViewWithItemInfo:(NSDictionary *)info;
@end
