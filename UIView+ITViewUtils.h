//
//  UIView+ITViewUtils.h
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIViewAutoresizingFlexibleSize (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

@interface UIView (ITViewUtils)
// load and return view from nib
+(id)viewWithNibName:(NSString *)name;
@end
