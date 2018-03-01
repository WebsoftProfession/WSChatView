//
//  WSChatEnvironment.h
//  WSChatView
//
//  Created by Praveen on 27/02/18.
//  Copyright © 2018 ds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSChatTextView.h"

@interface WSChatEnvironment : UIView<UITextViewDelegate>{
    CGRect previousRect;
    int lineCount;
    __weak IBOutlet NSLayoutConstraint *textContainerHeightConstraint;
    NSNotification *activeNotification;
    __weak IBOutlet UIView *bottomView;
}
@property (nonatomic,strong) IBOutlet UITableView *list;
@property (nonatomic,strong) IBOutlet UITextView *WSChatTextView;
@property (nonatomic,strong) NSString *placeHolder;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;


@end
