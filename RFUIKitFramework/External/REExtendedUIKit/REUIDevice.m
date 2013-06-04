//
//  REUIDevice.m
//  REUIKitFramework
//  https://github.com/oliromole/REExtendedUIKit.git
//
//  Created by Roman Oliichuk on 2013.05.10.
//  Copyright (c) 2012 Roman Oliichuk. All rights reserved.
//

/*
 Copyright (C) 2012 Roman Oliichuk. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions
 are met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors
 may be used to endorse or promote products derived from this
 software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "REUIDevice.h"

#import <sys/sysctl.h>

@implementation UIDevice (UIDeviceREUIDevice)

#pragma mark - Getting the Hardware Information.

- (NSString *)hardwareMachine
{
    char     *cHardwareMachine = NULL;
    size_t    cHardwareMachineSize = 0;
    NSString *nsHardwareMachine = nil;
    
    int result0 = sysctlbyname("hw.machine", NULL, &cHardwareMachineSize, NULL, 0);
    
    if ((result0 == 0) && (cHardwareMachineSize > 0))
    {
        cHardwareMachine = malloc(cHardwareMachineSize);
        
        if (cHardwareMachine)
        {
            memset(cHardwareMachine, 0, cHardwareMachineSize);
            
            int result1 = sysctlbyname("hw.machine", cHardwareMachine, &cHardwareMachineSize, NULL, 0);
            
            if (result1 == 0)
            {
                nsHardwareMachine = [[NSString alloc] initWithCString:cHardwareMachine encoding: NSUTF8StringEncoding];
            }
        }
        
        free(cHardwareMachine);
        cHardwareMachine = NULL;
    }
    
    return nsHardwareMachine;
}

- (NSString *)hardwareModel
{
    char     *cHardwareModel = NULL;
    size_t    cHardwareModelSize = 0;
    NSString *nsHardwareModel = nil;
    
    int result0 = sysctlbyname("hw.model", NULL, &cHardwareModelSize, NULL, 0);
    
    if ((result0 == 0) && (cHardwareModelSize > 0))
    {
        cHardwareModel = malloc(cHardwareModelSize);
        
        if (cHardwareModel)
        {
            memset(cHardwareModel, 0, cHardwareModelSize);
            
            int result1 = sysctlbyname("hw.model", cHardwareModel, &cHardwareModelSize, NULL, 0);
            
            if (result1 == 0)
            {
                nsHardwareModel = [[NSString alloc] initWithCString:cHardwareModel encoding: NSUTF8StringEncoding];
            }
        }
        
        free(cHardwareModel);
        cHardwareModel = NULL;
    }
    
    return nsHardwareModel;
}

@end
