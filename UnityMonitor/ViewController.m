//
//  ViewController.m
//  UnityMonitor
//
//  Created by Lukas Musy on 11/04/16.
//  Copyright (c) 2016 Lukas Musy. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioServices.h>
#import <objc/runtime.h>


#define RECEIVEPORT 3333


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.server = [[OSCServer alloc]init];
    self.server.delegate = self;
    [self.server listen:RECEIVEPORT];
    
    [self.vibrate_button addTarget:self action:@selector(vibrate) forControlEvents:UIControlEventTouchUpInside];
    self.patch = [[PDPatch alloc] initWithFile:@"main.pd"];
    
    float t = (float) YES;
//    [PdBase sendFloat:t toReceiver:@"mute"];

}

- (void)handleMessage:(OSCMessage*)message {
    //split address
    NSArray *components = [message.address componentsSeparatedByString:@"/"];
    if ([[components objectAtIndex:1] isEqualToString:@"profiler"]) {
        NSString *parameter = [components objectAtIndex:2];
        NSString *args = [[message.arguments valueForKey:@"description"] componentsJoinedByString:@":"];
//        NSString *subsection =[components objectAtIndex:1];
//        NSString *subsection_formatted = [[subsection stringByReplacingOccurrencesOfString:@"_" withString:@" "]capitalizedString];
        
        
        NSString *param_formated_sel = [parameter stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        param_formated_sel = [param_formated_sel lowercaseString];
        param_formated_sel = [param_formated_sel stringByAppendingString:@":"];
        
        SEL selector = NSSelectorFromString(param_formated_sel);
        if ([self respondsToSelector:selector]) {
            [self performSelector:selector withObject:[NSArray arrayWithObjects:parameter, args, nil]];
            
        }
    }
}

- (void)vsync:(NSArray *)container{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self displayParam:[container objectAtIndex:0] withValue: [container objectAtIndex:1]];
    });

}

- (void)mesh_memory:(NSArray *)container{
    
}

- (void)contacts:(NSArray *)container{
    if ([[container objectAtIndex:1] isEqualToString:@"1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self vibrate];
        });
    }
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
