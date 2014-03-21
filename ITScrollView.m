//
//  ITScrollView.m
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "ITScrollView.h"

BOOL ITScrollViewLayoutStyleHorizontalMask(ITScrollViewLayoutStyle layoutStyle)
{
    return (layoutStyle & 0x00FF);
}

BOOL ITScrollViewLayoutStyleFullFrameMask(ITScrollViewLayoutStyle layoutStyle)
{
    return (layoutStyle & 0xF0F0);
}

ITEdgeMargin ITEdgeMarginMake(CGFloat left, CGFloat top, CGFloat right, CGFloat bottom)
{
    return (ITEdgeMargin){left, top, right, bottom};
}

ITEdgeMargin const ITEdgeMarginZero = {0., 0., 0., 0.};

@interface ITScrollView()
{
    ITScrollViewLayoutStyle _layoutStyle;
    NSMutableArray *_scrollViewItems;
}
@end

@implementation ITScrollView
@synthesize scrollViewItems = _scrollViewItems;
@synthesize layoutStyle = _layoutStyle;
@dynamic delegate;

-(NSArray *)scrollViewItems
{
    if ([_scrollViewItems count]) {
        return _scrollViewItems;
    }
    return nil;
}

-(void)clearContent
{
    while ([_scrollViewItems count]) {
        [[_scrollViewItems lastObject] removeFromSuperview];
        [_scrollViewItems removeLastObject];
    }
    _scrollViewItems = nil;
    [self setContentSize:CGSizeZero];
    [self setContentOffset:CGPointZero];
}

-(void)reloadLayoutWithStyle:(ITScrollViewLayoutStyle)layoutStyle
{
    [self clearContent];
    NSInteger numberOfItem = [self.dataSource numberOfItemInITScrollView:self];
    if (numberOfItem > 0) {
        _scrollViewItems = [NSMutableArray arrayWithCapacity:numberOfItem];
        for (NSInteger idx = 0; idx < numberOfItem; idx++) {
            UIView *itemView = [self.dataSource ITScrollView:self viewAtIndex:idx];
            [self addSubview:itemView];
            [_scrollViewItems addObject:itemView];
        }
    }
}

-(CGRect)frameForViewAtIndex:(NSInteger)idx
{
    ITEdgeMargin margin = ITEdgeMarginZero;

    if ([self.dataSource respondsToSelector:@selector(ITScrollView:marginForViewAtIndex:)]) {
        margin = [self.dataSource ITScrollView:self marginForViewAtIndex:idx];
    }
    CGSize size = [[_scrollViewItems objectAtIndex:idx] frame].size;
    if (ITScrollViewLayoutStyleFullFrameMask(self.layoutStyle)) {
        size = CGSizeMake(self.frame.size.width - (margin.left + margin.right), self.frame.size.height - (margin.top + margin.bottom));
    }
    else if ([self.dataSource respondsToSelector:@selector(ITScrollView:sizeForViewAtIndex:)])
    {
        size = [self.dataSource ITScrollView:self sizeForViewAtIndex:idx];
    }

    return CGRectZero;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

-(void)dealloc
{
    [self clearContent];
}
@end
