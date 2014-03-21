//
//  UIView+ITViewUtils.m
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "UIView+ITViewUtils.h"

@implementation UIView (ITViewUtils)
+(id)viewWithNibName:(NSString *)name
{
    return [[[NSBundle mainBundle] loadNibNamed:name? name : NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}
@end
