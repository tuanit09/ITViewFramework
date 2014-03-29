//
//  ITNibToIBViewLoader.m
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "ITNibToIBViewLoader.h"
#import "UIView+ITViewUtils.h"

@implementation ITNibToIBViewLoader
// getter
-(UIView *)loadedView
{
    return [[self subviews] lastObject];
}

-(void)clearView
{
    UIView *loadedView = [self loadedView];
    if (loadedView) {
        [loadedView removeFromSuperview];
    }
}

-(void)loadNibName:(NSString *)loadedNibName
{
    [self clearView];
    if (loadedNibName) {
        UIView *view = [UIView viewWithNibName:loadedNibName];
        if (view) {
            view.frame = self.bounds;
            view.autoresizingMask = UIViewAutoresizingFlexibleSize;
            [self addSubview:view];
        }
    }
}

-(void)dealloc
{
    [self clearView];
}
@end
