//
//  ViewController.h
//  UnityMonitor
//
//  Created by Lukas Musy on 11/04/16.
//  Copyright (c) 2016 Lukas Musy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDPatch.h"

@class OscHandler;

@interface MonitorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) PDPatch *patch;
@property (strong, nonatomic) OscHandler *oschandler;

@property (nonatomic, strong) NSArray *monitorData;


- (void)displayParam: (NSString *)parameter withValue: (NSString *)value inSlot:(int)slot;

- (void)soundEnable:(BOOL)b;
- (void)soundFreq:(float)f;
- (void)soundInterval:(int)i;

- (void)vibrate;


@end

