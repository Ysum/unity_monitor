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
    
    [self.subsection_label setTextColor:[UIColor blueColor]];
    [self.parameter_label setTextColor:[UIColor blueColor]];
    [self.value_label setTextColor:[UIColor blueColor]];
    
    [self.parameter_label setText:parameter];
    [self.value_label setText: value];
    
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
