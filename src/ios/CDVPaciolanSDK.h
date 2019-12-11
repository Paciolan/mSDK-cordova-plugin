//
//  CDVPaciolanSDK.h
//
//  Created by Philip Briggs on 03/19/19.
//
//

#import <Cordova/CDV.h>

@interface CDVPaciolanSDK : CDVPlugin

- (void)show:(CDVInvokedUrlCommand*)command;
- (void)onTokenChanged:(CDVInvokedUrlCommand*)command;

@end
