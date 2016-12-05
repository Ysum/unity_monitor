//
//  PDController.m
//  UnityMonitor
//
//  Created by Lukas Musy on 11/07/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import "PDController.h"

@implementation PDController

-(instancetype)init {
    self.patch = [[PDPatch alloc] initWithFile:@"main.pd"];
    return self;
}

- (void)enable:(BOOL)b {
    float t = (float) b;
    [PdBase sendFloat:1 toReceiver:@"volume"];
    [PdBase sendFloat:t toReceiver:@"enable"];
}

- (void)freq:(float)f {
    [PdBase sendFloat:f toReceiver:@"freq"];
}

- (void)interval:(int)i {
    [PdBase sendFloat:i toReceiver:@"interval"];
}



@end
