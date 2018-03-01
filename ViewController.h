//
//  ViewController.h
//  WSChatView
//
//  Created by Praveen on 01/03/18.
//  Copyright © 2018 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSChatView.h"

@interface ViewController : UIViewController<WSChatViewDelegate>
{
    
    __weak IBOutlet WSChatView *chatView;
}

@end

