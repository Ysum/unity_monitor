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

@interface MonitorViewController : UIViewController

@property (strong, nonatomic) PDPatch *patch;
@property (strong, nonatomic) OscHandler *oschandler;


@property (weak, nonatomic) IBOutlet UILabel *parameter1_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter2_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter3_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter4_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter5_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter6_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter7_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter8_label;

@property (weak, nonatomic) IBOutlet UILabel *value1_label;
@property (weak, nonatomic) IBOutlet UILabel *value2_label;
@property (weak, nonatomic) IBOutlet UILabel *value3_label;
@property (weak, nonatomic) IBOutlet UILabel *value4_label;
@property (weak, nonatomic) IBOutlet UILabel *value5_label;
@property (weak, nonatomic) IBOutlet UILabel *value6_label;
@property (weak, nonatomic) IBOutlet UILabel *value7_label;
@property (weak, nonatomic) IBOutlet UILabel *value8_label;

- (void)displayParam: (NSString *)parameter withValue: (NSString *)value inSlot:(int)slot;

- (void)soundEnable:(BOOL)b;
- (void)soundFreq:(float)f;
- (void)soundInterval:(int)i;

- (void)vibrate;


@end

