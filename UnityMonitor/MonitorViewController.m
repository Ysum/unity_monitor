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


- (void)displayParam: (NSString *)parameter withValue: (NSString *)value {
    
    [self.parameter1_label setTextColor:[UIColor blueColor]];
    [self.value1_label setTextColor:[UIColor blueColor]];
    
    [self.parameter2_label setTextColor:[UIColor blueColor]];
    [self.value2_label setTextColor:[UIColor blueColor]];
    
    [self.parameter3_label setTextColor:[UIColor blueColor]];
    [self.value3_label setTextColor:[UIColor blueColor]];
    
    [self.parameter4_label setTextColor:[UIColor blueColor]];
    [self.value4_label setTextColor:[UIColor blueColor]];

    [self.parameter5_label setTextColor:[UIColor blueColor]];
    [self.value5_label setTextColor:[UIColor blueColor]];
    
    [self.parameter6_label setTextColor:[UIColor blueColor]];
    [self.value6_label setTextColor:[UIColor blueColor]];
    
    [self.parameter7_label setTextColor:[UIColor blueColor]];
    [self.value7_label setTextColor:[UIColor blueColor]];
    
    [self.parameter8_label setTextColor:[UIColor blueColor]];
    [self.value8_label setTextColor:[UIColor blueColor]];
    
    if ([parameter isEqualToString:@"VSync"]) {
        [self.parameter1_label setText:parameter];
        [self.value1_label setText: value];
    } else if ([parameter isEqualToString:@"Rendering"]) {
        [self.parameter2_label setText:parameter];
        [self.value2_label setText: value];
    } else if ([parameter isEqualToString:@"Physics"]) {
        [self.parameter3_label setText:parameter];
        [self.value3_label setText: value];
    } else if ([parameter isEqualToString:@"GC Allocated"]) {
        [self.parameter4_label setText:parameter];
        [self.value4_label setText: value];
    } else if ([parameter isEqualToString:@"Triangles"]) {
        [self.parameter5_label setText:parameter];
        [self.value5_label setText: value];
    } else if ([parameter isEqualToString:@"Mesh Memory"]) {
        [self.parameter6_label setText:parameter];
        [self.value6_label setText: value];
    } else if ([parameter isEqualToString:@"Total Audio CPU"]) {
        [self.parameter7_label setText:parameter];
        [self.value7_label setText: value];
    } else if ([parameter isEqualToString:@"Active Rigidbodies"]) {
        [self.parameter8_label setText:parameter];
        [self.value8_label setText: value];
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
