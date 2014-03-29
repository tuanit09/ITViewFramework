//
//  ITScrollView.h
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ITViewUtils.h"

typedef enum ITScrollViewLayoutStyle ITScrollViewLayoutStyle;

BOOL ITScrollViewLayoutStyleHorizontalMask(ITScrollViewLayoutStyle layoutStyle);
BOOL ITScrollViewLayoutStyleFullFrameMask(ITScrollViewLayoutStyle layoutStyle);

ITEdgeMargin ITEdgeMarginMake(CGFloat left, CGFloat top, CGFloat right, CGFloat bottom);
extern ITEdgeMargin const ITEdgeMarginZero;

typedef enum ITScrollViewLayoutStyle
{
    ITScrollViewStyleHorizontal = 0x0001, // horizontal layout. User determine the size of each item
    ITScrollViewStyleHorizontalFullFrame = 0x0010, // horizontal layout. each item will fit the frame of scroll
    ITScrollViewStyleVirtical = 0x0100,
    ITScrollViewStyleVirticalFullFrame = 0x1000
}ITScrollViewLayoutStyle;

@protocol ITScrollViewDataSource<NSObject>
@required
-(NSInteger)numberOfItemInITScrollView:(id)scrollView;
-(UIView *)ITScrollView:(id)scrollView viewAtIndex:(NSInteger)index;
@optional
-(CGSize)ITScrollView:(id)scrollView sizeForViewAtIndex:(NSInteger)index;
-(ITEdgeMargin)ITScrollView:(id)scrollView marginForViewAtIndex:(NSInteger)index;
@end


@protocol ITScrollViewDelegate <UIScrollViewDelegate>
// no new protocol
@end

@interface ITScrollView : UIScrollView
@property (weak, nonatomic) id<ITScrollViewDelegate>delegate; // override delegate
@property (weak, nonatomic) id<ITScrollViewDataSource>dataSource; // data source
@property (assign, nonatomic, readonly) ITScrollViewLayoutStyle layoutStyle;
@property (strong, nonatomic, readonly) NSArray *scrollViewItems;

-(void)reloadLayoutWithStyle:(ITScrollViewLayoutStyle)layoutStyle;
@end
