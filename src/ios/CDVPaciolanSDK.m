//
//  CDVPaciolanSDK.m
//
//  Created by Philip Briggs on 03/19/19.
//
//

#import "CDVPaciolanSDK.h"
#import "InstantiateViewControllerError.h"
#import <UIKit/UIKit.h>
#import "PaciolanSDKViewController.h"

@interface CDVPaciolanSDK (hidden)

-(PaciolanSDKViewController*) tryInstantiatePaciolanViewWithProps: (NSString*) props;
@end

@implementation CDVPaciolanSDK
PaciolanSDKViewController *viewController = nil;
- (void)show:(CDVInvokedUrlCommand*)command {
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    
    NSString* className = [command argumentAtIndex: 0];
    
    viewController = [self tryInstantiatePaciolanViewWithProps: className];
    [viewController setModalPresentationStyle: UIModalPresentationFullScreen];
    CDVAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate.window.rootViewController presentViewController:viewController animated:YES completion:nil];
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId ];
}
- (void)onTokenChanged:(CDVInvokedUrlCommand*)command {
    if(viewController){
        [viewController setTokenListener:^(NSString *token) {
            CDVPluginResult* pluginResult = [CDVPluginResult
                                             resultWithStatus:CDVCommandStatus_OK
                                             messageAsString:token];
            [pluginResult setKeepCallbackAsBool:true];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId ];
        }];
    }
}

- (PaciolanSDKViewController*) tryInstantiatePaciolanViewWithProps:(NSString *)props {
    @try {
        return [[PaciolanSDKViewController alloc] initWithString:props];
    } @catch (InstantiateViewControllerError* e) {
        NSLog(@"%@", e.reason);
    }
    
    return nil;
}

@end
