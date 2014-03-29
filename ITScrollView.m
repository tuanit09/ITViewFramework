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
    // clear subview
    [self clearContent];
    _layoutStyle = layoutStyle;
    // add new view items
    NSInteger numberOfItem = [self.dataSource numberOfItemInITScrollView:self];
    if (numberOfItem > 0) {
        _scrollViewItems = [NSMutableArray arrayWithCapacity:numberOfItem];
        for (NSInteger idx = 0; idx < numberOfItem; idx++) {
            UIView *itemView = [self.dataSource ITScrollView:self viewAtIndex:idx];
            [self addSubview:itemView];
            [_scrollViewItems addObject:itemView];
        }
    }
    // layout view items
    [self layoutViewItems];
}

-(void)layoutViewItems
{
    // initital value
    CGFloat positionX = 0.;
    CGFloat positionY = 0.;
    CGFloat contentSizeWidth = 0.;
    CGFloat contentSizeHeight = 0.;
    ITEdgeMargin margin;

    for (NSInteger idx = 0; idx < [_scrollViewItems count]; idx++) {
        // calculate margin
        margin = ITEdgeMarginZero;
        if ([self.dataSource respondsToSelector:@selector(ITScrollView:marginForViewAtIndex:)]) {
            margin = [self.dataSource ITScrollView:self marginForViewAtIndex:idx];
        }
        // Item to work on
        UIView *itemView = [_scrollViewItems objectAtIndex:idx];
        // calculate size
        CGSize size = itemView.frame.size;
        if (ITScrollViewLayoutStyleFullFrameMask(self.layoutStyle)) {
            size = CGSizeMake(self.frame.size.width - (margin.left + margin.right), self.frame.size.height - (margin.top + margin.bottom));
        }
        else if ([self.dataSource respondsToSelector:@selector(ITScrollView:sizeForViewAtIndex:)])
        {
            size = [self.dataSource ITScrollView:self sizeForViewAtIndex:idx];
        }
        // calculate frame
        CGRect frame = CGRectMake(positionX + margin.left, positionY + margin.top, size.width, size.height);
        itemView.frame = frame;
        // calculate content size
        contentSizeWidth = positionX + margin.right;
        contentSizeHeight = positionY + margin.bottom;
        // calculate position for next item
        if (ITScrollViewLayoutStyleHorizontalMask(_layoutStyle)) {
            positionX = contentSizeWidth;
        }
        else
        {
            positionY = contentSizeHeight;
        }
    }

    // setcontentsize
    [self setContentSize:CGSizeMake(contentSizeWidth, contentSizeHeight)];
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self layoutViewItems];
}

-(void)dealloc
{
    [self clearContent];
}
@end
