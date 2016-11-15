//
//  OSC_Handler.m
//  UnityMonitor
//
//  Created by Lukas Musy on 09/07/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import "OscHandler.h"
#import "MonitorViewController.h"

#define RECEIVEPORT 3333


@implementation OscHandler

- (id)initWithOwner:(MonitorViewController*)owner
{
    self = [super init];
    if (self) {
        self.owner = owner;
        
        self.server = [[OSCServer alloc]init];
        self.server.delegate = self;
        [self.server listen:RECEIVEPORT];
    }
    return self;
}

- (void)handleMessage:(OSCMessage*)message {
    
    //split address
    NSArray *components = [message.address componentsSeparatedByString:@"/"];
    if ([[components objectAtIndex:1] isEqualToString:@"UnityWatchdog"]) {
        
        //get adress and values fields
        NSString *displaySlot = [components objectAtIndex:2];
        int slotNumber = [[displaySlot substringFromIndex:[displaySlot length]-1] intValue];
        NSString *msg_type = [components objectAtIndex:3];
        NSString *parameter;
        if(![msg_type isEqualToString:@"Vibra"]) {
            parameter = [components objectAtIndex:4];
        }
        
        //get argument
        NSString *arg = [[message.arguments valueForKey:@"description"] componentsJoinedByString:@":"];
        
        //dispatch message target in the GUI thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //process based on messege type
            if ([msg_type isEqualToString:@"Display"]) {
                //display
                [self.owner displayParam:parameter withValue:arg inSlot:slotNumber];
                
            } else if ([msg_type isEqualToString:@"Vibra"]) {
                //vibra
                [self.owner vibraAlarmfromSlot:slotNumber];
                
            } else if ([msg_type isEqualToString:@"Sound"]) {
                if ([parameter isEqualToString:@"Freq"]) {
                    //sound freq if applicable
                    [self.owner soundFreq:[arg floatValue]];
                    
                } else if ([parameter isEqualToString:@"Interval"]) {
                    //start beep
                    [self.owner soundAlarmWithRate:[arg intValue] fromSlot:slotNumber];
                    //stop audio
                    if ([arg intValue] == 0) {
                        [self.owner soundEnable:NO];
                    }
                    
                    //timer for disabling audio when no more messages received
                    if (!timeoutTimer) {
                        [self startTimer];
                    } else {
                        //reset timer
                        [timeoutTimer invalidate];
                        [self startTimer];
                    }
                }
            }
        });
        
    }
    
}

- (void)startTimer {
    timeoutTimer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(timeoutDetect:) userInfo:nil repeats:NO];
}

- (void)timeoutDetect:(NSTimer*)sender {
    [self.owner soundEnable:NO];
    [self.owner unmarkAll];
    [timeoutTimer invalidate];
}




@end
