//
//  WSChatBubbleView.h
//  WSChatView
//
//  Created by WebsoftProfession on 12/8/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WSChatLabel.h"

typedef enum {
    ArrowDirectionLeftTop=0,
    ArrowDirectionLeftBottom,
    ArrowDirectionRightTop,
    ArrowDirectionRightBottom
}ArrowDirectionStyle;

@interface WSChatBubbleView : UIView
{
    
}
@property (nonatomic,strong) IBOutlet WSChatLabel *WSChatLabel;
@property (nonatomic,strong) IBOutlet UILabel *lblChatText;
@property (nonatomic,strong) UIColor *borderColor;
@property (nonatomic,strong) UIColor *backColor;

@property (assign) int arrowDirectionStyle;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *headerText;
@property (nonatomic,strong) NSString *footerText;
@property (assign) BOOL isSent;
@property (assign) BOOL isDelivered;
@property (assign) BOOL isSeen;
@property (nonatomic,strong) NSString *sentStatusImage;
@property (nonatomic,strong) NSString *deliveredStatusImage;
@property (nonatomic,strong) NSString *seenStatusImage;

// shared object properties
@property (nonatomic,strong) UIColor *senderBackgroundColor;
@property (nonatomic,strong) UIColor *receiverBackgroundColor;
@property (nonatomic,strong) UIColor *senderTextColor;
@property (nonatomic,strong) UIColor *receiverTextColor;
@property (nonatomic,strong) UIFont *font;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIColor *senderHeaderColor;
@property (nonatomic,strong) UIColor *receiverHeaderColor;
@property (nonatomic,strong) UIColor *senderFooterColor;
@property (nonatomic,strong) UIColor *receiverFooterColor;
@property (nonatomic,assign) BOOL isDrawStatus;

+ (instancetype)sharedInstance;


-(void)reloadView;
-(CGFloat)heightForMessage:(NSString *)msg containerWidth:(CGFloat)width;

@end
