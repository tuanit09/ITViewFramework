//
//  UIView+ITViewUtils.h
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITViewItem.h"

typedef struct ITEdgeMargin
{
    CGFloat left;
    CGFloat top;
    CGFloat right;
    CGFloat bottom;
}ITEdgeMargin;


#define UIViewAutoresizingFlexibleSize (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

@interface NSArray (ITNibToIBViewLoader)
-(void)loadNibName:(NSString *)name;
-(NSArray *)loadedViews;
@end

@interface NSArray (ITViewItemUtils)
-(void)ITSetElementsDelegate:(__weak id<ITViewItemDelegate>)delegate;
//-(void)adjustSubviewsToRect:(CGRect)rect margin:(ITEdgeMargin)margin horizontal:(BOOL)isHorizontal;
//-(void)adjustHorizonTalSubviewsToRect:(CGRect)rect margin:(ITEdgeMargin)margin;
//-(void)adjustVerticalSubviewsToRect:(CGRect)rect margin:(ITEdgeMargin)margin;
@end


@interface UIView (ITViewUtils)
// load and return view from nib
+(id)viewWithNibName:(NSString *)name;
@end
