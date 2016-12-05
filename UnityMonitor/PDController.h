//
//  PDController.h
//  UnityMonitor
//
//  Created by Lukas Musy on 11/07/16.
//  Copyright © 2016 Lukas Musy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDPatch.h"


@interface PDController : NSObject

@property (nonatomic, strong) PDPatch *patch;

- (void)enable:(BOOL)b;
- (void)freq:(float)f;
- (void)interval:(int)i;

@end
