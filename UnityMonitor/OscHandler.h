//
//  OSC_Handler.h
//  UnityMonitor
//
//  Created by Lukas Musy on 09/07/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OSCKit/OSCKit.h>

@class MonitorViewController;

@interface OscHandler : NSObject <OSCServerDelegate> {
//    NSDate *startTimer;
    NSTimer *timeoutTimer;
}

@property (strong, nonatomic) OSCServer *server;
@property (strong, nonatomic) MonitorViewController *owner;


- (instancetype)initWithOwner:(MonitorViewController*)owner;
- (void)handleMessage:(OSCMessage*)message;

- (void)timeoutDetect:(NSTimer*)sender;
- (void)startTimer;

@end
