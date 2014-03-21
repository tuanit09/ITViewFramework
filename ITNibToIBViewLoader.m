//
//  ITNibToIBViewLoader.m
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "ITNibToIBViewLoader.h"
#import "UIView+ITViewUtils.h"

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
    }
    return nil;
}

@end


@implementation ITNibToIBViewLoader
// getter
-(UIView *)loadedView
{
    return [[self subviews] lastObject];
}

// prevent other sub views from being added to this view loader
-(void)addSubview:(UIView *)view
{
    // do nothing, no sub view can be loaded into this view. It only contains view loaded from nib.
}

-(void)loadNibName:(NSString *)loadedNibName
{
    UIView *view = [UIView viewWithNibName:loadedNibName];
    if (view) {
        view.frame = self.bounds;
        view.autoresizingMask = UIViewAutoresizingFlexibleSize;
        [super addSubview:view];
    }
}

-(void)dealloc
{
    UIView *loadedView = [self loadedView];
    if (loadedView) {
        [loadedView removeFromSuperview];
    }
}
@end
