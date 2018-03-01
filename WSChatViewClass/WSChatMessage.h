//
//  WSChatMessage.h
//  WSChatView
//
//  Created by Praveen on 26/02/18.
//  Copyright © 2018 ds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WSChatMessage : NSObject<NSCoding, NSCopying>

@property (copy, nonatomic) NSString *senderId;
@property (copy, nonatomic) NSString *senderName;
@property (copy, nonatomic) NSDate *messageDate;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) UIImage *mediaImage;

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text
                      mediaImage:(UIImage *)media;
@end
