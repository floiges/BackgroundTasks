//
//  ViewController.h
//  BackgroundTasks
//
//  Created by 224 on 15/3/20.
//  Copyright (c) 2015年 zoomlgd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^fetchBlock)(NSError *error,NSArray *results);

@interface ViewController : UIViewController

- (void)fetchDataResult:(fetchBlock) block;

@end
