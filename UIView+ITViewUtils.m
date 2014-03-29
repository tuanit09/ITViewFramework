//
//  UIView+ITViewUtils.m
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "UIView+ITViewUtils.h"
#import "ITNibToIBViewLoader.h"
#import "ITViewItem.h"

@implementation NSArray(ITNibToIBViewLoader)
-(void)loadNibName:(NSString *)name
{
    for (ITNibToIBViewLoader *loader in self) {
        [loader loadNibName:name];
    }
}

-(NSArray *)loadedViews
{
    if ([self count]) {
        NSMutableArray *loadedViews = [NSMutableArray arrayWithCapacity:[self count]];
        for (ITNibToIBViewLoader *loader in self) {
            UIView *loadedView = [loader loadedView];
            [loadedViews addObject:loadedView? loadedView : [NSNull null]];
        }
        return loadedViews;
    }
    return nil;
}

@end


@implementation NSArray (ITViewItemUtils)
-(void)ITSetElementsDelegate:(__weak id<ITViewItemDelegate>)delegate
{
    for (id obj in self) {
        [obj setDelegate:delegate];
    }
}
//-(void)adjustHorizonTalSubviewsToRect:(CGRect)rect margin:(ITEdgeMargin)margin
//{
//    [self adjustSubviewsToRect:rect margin:margin horizontal:YES];
//}
//
//-(void)adjustVerticalSubviewsToRect:(CGRect)rect margin:(ITEdgeMargin)margin
//{
//    [self adjustSubviewsToRect:rect margin:margin horizontal:NO];
//}
//
//-(void)adjustSubviewsToRect:(CGRect)rect margin:(ITEdgeMargin)margin horizontal:(BOOL)isHorizontal
//{
//    
//}
@end


@implementation UIView (ITViewUtils)
+(id)viewWithNibName:(NSString *)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name? name : NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
