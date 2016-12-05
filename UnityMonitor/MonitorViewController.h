//
//  ViewController.h
//  UnityMonitor
//
//  Created by Lukas Musy on 11/04/16.
//  Copyright (c) 2016 Lukas Musy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDController.h"

@class OscHandler;

@interface MonitorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

//View
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *monitorData;

//OSC
@property (nonatomic, strong) OscHandler *oschandler;

//PD
@property (nonatomic, strong) PDController *pd;

- (void)displayParam: (NSString *)parameter withValue: (NSString *)interval inSlot:(int)slot;
- (void)markSlotAlarmActive:(BOOL)b Slot:(int)slot;
- (void)unmarkAll;

- (void)soundAlarmWithRate: (int)value fromSlot:(int)slot;
- (void)vibraAlarmfromSlot:(int)slot;

- (void)vibrate;



@end

