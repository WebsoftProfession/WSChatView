//
//  WSChatMessage.m
//  WSChatView
//
//  Created by Praveen on 26/02/18.
//  Copyright © 2018 ds. All rights reserved.
//

#import "WSChatMessage.h"

@implementation WSChatMessage

- (instancetype)initWithSenderId:(NSString *)senderId
               senderDisplayName:(NSString *)senderDisplayName
                            date:(NSDate *)date
                            text:(NSString *)text
                            mediaImage:(UIImage *)media
{
    NSParameterAssert(text != nil);
    NSParameterAssert(senderId != nil);
    NSParameterAssert(senderDisplayName != nil);
    NSParameterAssert(date != nil);
    
    self = [super init];
    if (self) {
        _senderId = [senderId copy];
        _senderName = [senderDisplayName copy];
        _messageDate = [date copy];
        _message = text;
        _mediaImage = media;
    }
    return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        _senderId = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderId))];
        _senderName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(senderName))];
        _messageDate = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(messageDate))];
        
        _message = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(message))];
        
        _mediaImage = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(mediaImage))];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.senderId forKey:NSStringFromSelector(@selector(senderId))];
    [aCoder encodeObject:self.senderName forKey:NSStringFromSelector(@selector(senderName))];
    [aCoder encodeObject:self.messageDate forKey:NSStringFromSelector(@selector(messageDate))];
    [aCoder encodeObject:self.message forKey:NSStringFromSelector(@selector(message))];
    
    if ([self.mediaImage conformsToProtocol:@protocol(NSCoding)]) {
        [aCoder encodeObject:self.mediaImage forKey:NSStringFromSelector(@selector(mediaImage))];
    }
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    return [[[self class] allocWithZone:zone] initWithSenderId:self.senderId senderDisplayName:self.senderName date:self.messageDate text:self.message mediaImage:self.mediaImage];
}

@end
