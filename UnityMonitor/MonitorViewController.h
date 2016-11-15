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

@property (nonatomic, strong) PDPatch *patch;
@property (nonatomic, strong) OscHandler *oschandler;

@property (nonatomic, strong) NSMutableArray *monitorData;

@property (nonatomic, strong) UITableView *tableView;

- (void)displayParam: (NSString *)parameter withValue: (NSString *)interval inSlot:(int)slot;
- (void)soundAlarmWithRate: (int)value fromSlot:(int)slot;
- (void)vibraAlarmfromSlot:(int)slot;

- (void)markPropAlarmActive:(BOOL)b Slot:(int)slot;

- (void)soundEnable:(BOOL)b;
- (void)soundFreq:(float)f;
- (void)soundInterval:(int)i;

- (void)panic;

- (void)vibrate;

- (void)unmarkAll;


@end

