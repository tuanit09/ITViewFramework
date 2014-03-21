//
//  ITViewItem.m
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import "ITViewItem.h"

@interface ITViewItem()
@property (strong, nonatomic) id bar;
@end

@implementation ITViewItem
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"undefined key %@", key);
    [super setValue:value forUndefinedKey:key];
}
-(void)updateViewWithItemInfo:(NSDictionary *)info
{
    [self setValuesForKeysWithDictionary:info];
}
@end
