//
//  RFTreeViewController.h
//  RFUIKitFramework
//
//  Created by Roman Oliichuk on 02/08/2012.
//  Copyright (c) 2012 Oliromole. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "RFUIKitFramework.h"

@interface RFTreeViewController : UIViewController
<
    RFUITreeViewDataSource,
    RFUITreeViewDelegate
>
{
@private
    
}

// Managing the View

@property (nonatomic, readonly) RFUITreeView *treeView;

@end
