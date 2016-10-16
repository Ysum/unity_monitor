//
//  ViewController.m
//  UnityMonitor
//
//  Created by Lukas Musy on 11/04/16.
//  Copyright (c) 2016 Lukas Musy. All rights reserved.
//

#import <AudioToolbox/AudioServices.h>
#import <objc/runtime.h>
#import "MonitorViewController.h"
#import "OscHandler.h"



@interface MonitorViewController ()


@end

@implementation MonitorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.vibrate_button addTarget:self action:@selector(vibrate) forControlEvents:UIControlEventTouchUpInside];
    self.patch = [[PDPatch alloc] initWithFile:@"main.pd"];
    self.oschandler = [[OscHandler alloc]initWithOwner:self];
    
    float t = (float) YES;
//    [PdBase sendFloat:t toReceiver:@"mute"];

}


- (void)displayParam: (NSString *)parameter withValue: (NSString *)value inSlot:(int)slot{
    
    switch (slot) {
        case 1: {
            [self.parameter1_label setTextColor:[UIColor blueColor]];
            [self.value1_label setTextColor:[UIColor blueColor]];
            [self.parameter1_label setText:parameter];
            [self.value1_label setText: value];
            break;
        }
        case 2: {
            [self.parameter2_label setTextColor:[UIColor blueColor]];
            [self.value2_label setTextColor:[UIColor blueColor]];
            [self.parameter2_label setText:parameter];
            [self.value2_label setText: value];
            break;
        }
        case 3: {
            [self.parameter3_label setTextColor:[UIColor blueColor]];
            [self.value3_label setTextColor:[UIColor blueColor]];
            [self.parameter3_label setText:parameter];
            [self.value3_label setText: value];
            break;
        }
        case 4: {
            [self.parameter4_label setTextColor:[UIColor blueColor]];
            [self.value4_label setTextColor:[UIColor blueColor]];
            [self.parameter4_label setText:parameter];
            [self.value4_label setText: value];
            break;
        }
        case 5: {
            [self.parameter5_label setTextColor:[UIColor blueColor]];
            [self.value5_label setTextColor:[UIColor blueColor]];
            [self.parameter5_label setText:parameter];
            [self.value5_label setText: value];
            break;
        }
        case 6: {
            [self.parameter6_label setTextColor:[UIColor blueColor]];
            [self.value6_label setTextColor:[UIColor blueColor]];
            [self.parameter6_label setText:parameter];
            [self.value6_label setText: value];
            break;
        }
        case 7: {
            [self.parameter7_label setTextColor:[UIColor blueColor]];
            [self.value7_label setTextColor:[UIColor blueColor]];
            [self.parameter7_label setText:parameter];
            [self.value7_label setText: value];
            break;
        }
        case 8: {
            [self.parameter8_label setTextColor:[UIColor blueColor]];
            [self.value8_label setTextColor:[UIColor blueColor]];
            [self.parameter8_label setText:parameter];
            [self.value8_label setText: value];
            break;
        }
    }


    
}

- (IBAction)mute:(id)sender {
    UIButton *button = (UIButton *)sender;
    float t = (float) YES;
    [PdBase sendFloat:t toReceiver:@"mute"];
    
}

- (IBAction)freq:(id)sender {
    UISlider *slider = (UISlider *)sender;
    [PdBase sendFloat:[slider value] toReceiver:@"freq"];

}


- (void)vibrate {
   // NSLog(@"vibrrrration");
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
