//
//  ITNibToIBViewLoader.h
//  CloudReader
//
//  Created by Tuan Anh Nguyen on 3/21/14.
//  Copyright (c) 2014 Home. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITNibToIBViewLoader : UIView
@property (strong, nonatomic, readonly) UIView *loadedView;
-(void)loadNibName:(NSString *)nibName;
@end
