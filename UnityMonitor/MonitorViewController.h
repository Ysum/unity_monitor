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


@property (weak, nonatomic) IBOutlet UILabel *subsection_label;
@property (weak, nonatomic) IBOutlet UILabel *parameter_label;
@property (weak, nonatomic) IBOutlet UILabel *value_label;
@property (weak, nonatomic) IBOutlet UIButton *vibrate_button;
@property (weak, nonatomic) IBOutlet UIButton *mute_button;
@property (weak, nonatomic) IBOutlet UISlider *freq_slider;

- (void)displayParam: (NSString *)parameter withValue: (NSString *)value;
- (void)vibrate;


@end

