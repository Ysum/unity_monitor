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
    
    self.oschandler = [[OscHandler alloc]initWithOwner:self];
    self.pd = [[PDController alloc] init];
    
    // init blank monitor data
    _monitorData = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        NSMutableArray *watcher = [NSMutableArray arrayWithObjects:@"", @"", @"", nil];
        [_monitorData addObject:watcher];
    }
}

- (void)loadView {
    _tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView reloadData];
    
    _tableView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection = NO;
    self.view = _tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_monitorData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Unity Profiler Watchers";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *watcher = @"Watcher";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:watcher];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:watcher];
    }
    
    NSMutableArray *data = [_monitorData objectAtIndex:indexPath.row];
    
    cell.textLabel.text =  [data objectAtIndex:0];
    cell.detailTextLabel.text = [data objectAtIndex:1];
    
    if ([[data objectAtIndex:2] isEqual:@"marked"]) {
        cell.backgroundColor = [UIColor redColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        
    } else {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blueColor];
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }
  
    return cell;
}

- (void)displayParam: (NSString *)parameter withValue: (NSString *)value inSlot:(int)slot{
    NSMutableArray *entry = [[NSMutableArray alloc] init];
    [entry addObjectsFromArray:@[parameter, value, [NSNull null]]];
    [_monitorData replaceObjectAtIndex:slot-1 withObject:entry];
    [_tableView reloadData];
}

- (void)soundAlarmWithRate: (int)interval fromSlot:(int)slot {
    [[_monitorData objectAtIndex:slot-1] replaceObjectAtIndex:2 withObject:@"marked"];
    [_pd enable:YES];
    [_pd interval:interval];
    [self markSlotAlarmActive:YES Slot:slot];
}

- (void)vibraAlarmfromSlot:(int)slot {
    [self vibrate];
}

- (void)markSlotAlarmActive:(BOOL)b Slot:(int)slot {
    [[_monitorData objectAtIndex:slot-1] replaceObjectAtIndex:2 withObject:b?@"marked":@""];
}

- (void)unmarkAll {
    for (int i = 1; i <= 10; i++) {
        [self markSlotAlarmActive:NO Slot:i];
    }
}

- (void)vibrate {
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)soundEnable: (BOOL)on {
    [_pd enable:on];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
