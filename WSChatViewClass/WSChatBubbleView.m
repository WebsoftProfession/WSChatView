//
//  WSChatBubbleView.m
//  WSChatView
//
//  Created by WebsoftProfession on 12/8/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "WSChatBubbleView.h"

@implementation WSChatBubbleView


+ (instancetype)sharedInstance
{
    static WSChatBubbleView *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WSChatBubbleView alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    // initialize default properties
//    [self setupInitialProperties];
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    
    CGFloat textContainerWidth = rect.size.width-rect.size.width*0.30;
    if (self.image) {
        textContainerWidth = 200-30;
    }
    CGRect textRect = [self.message boundingRectWithSize:CGSizeMake(textContainerWidth, CGFLOAT_MAX)
                                                          options:NSStringDrawingUsesLineFragmentOrigin
                                                       attributes:attributes
                                                          context:nil];
    
    CGFloat minimumHeight = 50.0;
    CGFloat minimumWidth = 100.0;
    
    if (self.image) {
        minimumHeight = 220;
        minimumWidth = 200;
    }
    else{
        minimumWidth = minimumWidth + textRect.size.width;
    }
    minimumHeight = minimumHeight + textRect.size.height;
    
    CGRect innerRect = CGRectMake(10, 10, minimumWidth, minimumHeight);
//    self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, minimumHeight);
    
//    switch (self.arrowDirectionStyle) {
//        case ArrowDirectionLeftBottom:
//        {
//            self.backColor = [WSChatBubbleView sharedInstance].receiverBackgroundColor;
//            
//        }
//            break;
//        case ArrowDirectionRightTop:
//        {
//            self.backColor = [WSChatBubbleView sharedInstance].senderBackgroundColor;
//        }
//            break;
//        case ArrowDirectionRightBottom:
//        {
//            self.backColor = [WSChatBubbleView sharedInstance].senderBackgroundColor;
//        }
//            break;
//            
//        default:{
//            self.backColor = [WSChatBubbleView sharedInstance].receiverBackgroundColor;
//        }
//            break;
//    }
//    self.message = self.message;
//    self.font = [UIFont fontWithName:@"Arial" size:14.0];
//    self.arrowDirectionStyle = self.arrowDirectionStyle;
//    [self drawAllPathsInRect:innerRect];
    
    if (!self.WSChatLabel) {
        self.WSChatLabel = [[WSChatLabel alloc] initWithFrame:innerRect];
        [self addSubview:self.WSChatLabel];
    }
    
    switch (self.arrowDirectionStyle) {
        case ArrowDirectionLeftBottom:
        {
            self.WSChatLabel.backColor = self.receiverBackgroundColor;
            self.WSChatLabel.textColor = self.receiverTextColor;
            self.WSChatLabel.headerColor = self.receiverHeaderColor;
            self.WSChatLabel.footerColor = self.receiverFooterColor;
        }
            break;
        case ArrowDirectionRightTop:
        {
            self.WSChatLabel.backColor = self.senderBackgroundColor;
            self.WSChatLabel.textColor = self.senderTextColor;
            self.WSChatLabel.headerColor = self.senderHeaderColor;
            self.WSChatLabel.footerColor = self.senderFooterColor;
        }
            break;
        case ArrowDirectionRightBottom:
        {
            self.WSChatLabel.backColor = self.senderBackgroundColor;
            self.WSChatLabel.textColor = self.senderTextColor;
            self.WSChatLabel.headerColor = self.senderHeaderColor;
            self.WSChatLabel.footerColor = self.senderFooterColor;
        }
            break;
            
        default:{
            self.WSChatLabel.backColor = self.receiverBackgroundColor;
            self.WSChatLabel.textColor = self.receiverTextColor;
            self.WSChatLabel.headerColor = self.receiverHeaderColor;
            self.WSChatLabel.footerColor = self.receiverFooterColor;
        }
            break;
    }
    
    self.WSChatLabel.seenStatusImage = self.seenStatusImage;
    
    self.WSChatLabel.textHeight = textRect.size.height;
    self.WSChatLabel.frame = innerRect;
    self.WSChatLabel.message = self.message;
    self.WSChatLabel.isDrawStatus = self.isDrawStatus;
    self.WSChatLabel.headerText = self.headerText;
    self.WSChatLabel.footerText = self.footerText;
    
    self.WSChatLabel.font = self.font;
    self.WSChatLabel.arrowDirectionStyle = self.arrowDirectionStyle;
    self.WSChatLabel.backgroundColor = [UIColor clearColor];
    self.WSChatLabel.image = self.image;
    [self.WSChatLabel setNeedsDisplay];
    
//    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:5.0];
//    if (self.backColor) {
//        [self.backColor setFill];
//    }
//    else{
//        [[UIColor redColor] setFill];
//    }
//    [rectPath fill];
//    [self drawString:self.message withFont:self.font inRect:innerRect];
//
//    CGPoint startPoint = CGPointZero;
//    CGPoint endPoint1 = CGPointZero;
//    CGPoint endPoint2 = CGPointZero;
//    CGPoint centerPoint1 = CGPointZero;
//    CGPoint centerPoint2 = CGPointZero;
//
//
//    // drawing border for rectPath
//    if (self.borderColor) {
//        [rectPath setLineWidth:1.0];
//        [[UIColor lightGrayColor] setStroke];
//        [rectPath stroke];
//    }
//
//    switch (self.arrowDirectionStyle) {
//        case ArrowDirectionLeftBottom:
//        {
//
//
//
//
//            self.lblChatText.textAlignment = NSTextAlignmentLeft;
//            startPoint = CGPointMake(0, innerRect.origin.y+innerRect.size.height-10);
//            endPoint1 = CGPointMake(15, innerRect.origin.y+innerRect.size.height-10);
//            endPoint2 = CGPointMake(15, innerRect.origin.y+innerRect.size.height-20);
//            centerPoint1 = CGPointMake(7.5, innerRect.origin.y+innerRect.size.height);
//            centerPoint2 = CGPointMake(7.5, innerRect.origin.y+innerRect.size.height-5);
//        }
//            break;
//        case ArrowDirectionRightTop:
//        {
//            NSDictionary *attributes = @{NSFontAttributeName: self.lblChatText.font};
//            // NSString class method: boundingRectWithSize:options:attributes:context is
//            // available only on ios7.0 sdk.
//            CGRect textRect = [self.lblChatText.text boundingRectWithSize:CGSizeMake(innerRect.size.width, CGFLOAT_MAX)
//                                                              options:NSStringDrawingUsesLineFragmentOrigin
//                                                           attributes:attributes
//                                                              context:nil];
//            CGFloat heightRatio = 0;
//            if (textRect.size.height>self.lblChatText.frame.size.height) {
//                heightRatio = textRect.size.height - self.lblChatText.frame.size.height;
//            }
//
////            self.lblChatText.frame = CGRectMake(innerRect.size.width+15-textRect.size.width, self.lblChatText.frame.origin.y, textRect.size.width-15, self.lblChatText.frame.size.height+heightRatio);
////            self.lblChatText.textAlignment = NSTextAlignmentRight;
//            startPoint = CGPointMake(rect.size.width, innerRect.origin.y+10);
//            endPoint1 = CGPointMake(rect.size.width-15, innerRect.origin.y+10);
//            endPoint2 = CGPointMake(rect.size.width-15, innerRect.origin.y+20);
//            centerPoint1 = CGPointMake(rect.size.width-7.5, innerRect.origin.y);
//            centerPoint2 = CGPointMake(rect.size.width-7.5, innerRect.origin.y+5);
//        }
//            break;
//        case ArrowDirectionRightBottom:
//        {
////            self.lblChatText.textAlignment = NSTextAlignmentRight;
//            startPoint = CGPointMake(rect.size.width, innerRect.origin.y+innerRect.size.height-10);
//            endPoint1 = CGPointMake(rect.size.width-15, innerRect.origin.y+innerRect.size.height-10);
//            endPoint2 = CGPointMake(rect.size.width-15, innerRect.origin.y+innerRect.size.height-20);
//            centerPoint1 = CGPointMake(rect.size.width-7.5, innerRect.origin.y+innerRect.size.height);
//            centerPoint2 = CGPointMake(rect.size.width-7.5, innerRect.origin.y+innerRect.size.height-5);
//        }
//            break;
//
//        default:{
//
//            self.lblChatText.textAlignment = NSTextAlignmentLeft;
//            startPoint = CGPointMake(0, innerRect.origin.y+10);
//            endPoint1 = CGPointMake(15, innerRect.origin.y+10);
//            endPoint2 = CGPointMake(15, innerRect.origin.y+20);
//            centerPoint1 = CGPointMake(7.5, innerRect.origin.y);
//            centerPoint2 = CGPointMake(7.5, innerRect.origin.y+5);
//
//        }
//            break;
//    }
//
//
//    UIBezierPath *arrowPath1 = [UIBezierPath bezierPath];
//    [arrowPath1 moveToPoint:startPoint];
//    [arrowPath1 addQuadCurveToPoint:endPoint1 controlPoint:centerPoint1];
//
//    // drawing border for arrowPath1
//    if (self.borderColor) {
//        [arrowPath1 setLineWidth:1.0];
//        [[UIColor lightGrayColor] setStroke];
//        [arrowPath1 stroke];
//    }
//
//
//    UIBezierPath *arrowPath2 = [UIBezierPath bezierPath];
//    [arrowPath2 moveToPoint:startPoint];
//    [arrowPath2 addQuadCurveToPoint:endPoint2 controlPoint:centerPoint2];
//
//    // drawing border for arrowPath2
//    if (self.borderColor) {
//        [arrowPath2 setLineWidth:1.0];
//        [[UIColor redColor] setStroke];
//        [arrowPath2 stroke];
//    }
//
//    [arrowPath1 appendPath:arrowPath2];
//    [arrowPath1 addLineToPoint:endPoint1];
//    if (self.backColor) {
//        [self.backColor setFill];
//    }
//    else{
//        [[UIColor redColor] setFill];
//    }
//
//    [arrowPath1 addClip];
//    [arrowPath1 setUsesEvenOddFillRule:YES];
//    [arrowPath1 fill];
//    [arrowPath1 setUsesEvenOddFillRule:NO];
//
//    if (!self.lblChatText) {
//
//    }
    
    
    
}


-(void)setupInitialProperties{
    
    if (![WSChatBubbleView sharedInstance].senderBackgroundColor) {
        [WSChatBubbleView sharedInstance].senderBackgroundColor = [UIColor colorWithRed:215.0f/255 green:255.0f/255 blue:160.0f/255 alpha:1.0];
    }
    
    if (![WSChatBubbleView sharedInstance].receiverBackgroundColor) {
        [WSChatBubbleView sharedInstance].receiverBackgroundColor = [UIColor whiteColor];
    }
    
    if (![WSChatBubbleView sharedInstance].senderTextColor) {
        [WSChatBubbleView sharedInstance].senderTextColor = [UIColor blackColor];
    }
    
    if (![WSChatBubbleView sharedInstance].receiverTextColor) {
        [WSChatBubbleView sharedInstance].senderTextColor = [UIColor blackColor];
    }
    
    if (![WSChatBubbleView sharedInstance].font) {
        [WSChatBubbleView sharedInstance].font = [UIFont fontWithName:@"Arial" size:14];
    }
}

-(void)drawAllPathsInRect:(CGRect)rect{

    if(self.arrowDirectionStyle==ArrowDirectionRightTop){
        
        rect = CGRectMake(self.frame.size.width-30-rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    }
    else{
        rect = CGRectMake(rect.origin.x+20, rect.origin.y, rect.size.width, rect.size.height);
    }
    
    
    
    
//    CGRect innerRect = CGRectMake(10, 10, rect.size.width-20, rect.size.height-20);
//    CGRect innerRect = rect;
    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5.0];
    
    [[UIColor blueColor] setStroke];
    [rectPath stroke];
    
//    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:5.0];
//
    [self.backColor setFill];
//    [rectPath fill];
//
    [self drawString:self.message withFont:[WSChatBubbleView sharedInstance].font inRect:rectPath.bounds];
//
//    CGPoint startPoint = CGPointZero;
//    CGPoint endPoint1 = CGPointZero;
//    CGPoint endPoint2 = CGPointZero;
//    CGPoint centerPoint1 = CGPointZero;
//    CGPoint centerPoint2 = CGPointZero;
//
//
//    // drawing border for rectPath
//    if ([WSChatBubbleView sharedInstance].borderColor) {
//        [rectPath setLineWidth:1.0];
//        [[UIColor lightGrayColor] setStroke];
//        [rectPath stroke];
//    }
//
//    switch (self.arrowDirectionStyle) {
//        case ArrowDirectionLeftBottom:
//        {
//            startPoint = CGPointMake(0, innerRect.origin.y+innerRect.size.height-10);
//            endPoint1 = CGPointMake(15, innerRect.origin.y+innerRect.size.height-10);
//            endPoint2 = CGPointMake(15, innerRect.origin.y+innerRect.size.height-20);
//            centerPoint1 = CGPointMake(7.5, innerRect.origin.y+innerRect.size.height);
//            centerPoint2 = CGPointMake(7.5, innerRect.origin.y+innerRect.size.height-5);
//        }
//            break;
//        case ArrowDirectionRightTop:
//        {
//            startPoint = CGPointMake(self.frame.size.width, innerRect.origin.y+10);
//            endPoint1 = CGPointMake(self.frame.size.width-15, innerRect.origin.y+10);
//            endPoint2 = CGPointMake(self.frame.size.width-15, innerRect.origin.y+20);
//            centerPoint1 = CGPointMake(self.frame.size.width-7.5, innerRect.origin.y);
//            centerPoint2 = CGPointMake(self.frame.size.width-7.5, innerRect.origin.y+5);
//        }
//            break;
//        case ArrowDirectionRightBottom:
//        {
//            startPoint = CGPointMake(self.frame.size.width, innerRect.origin.y+innerRect.size.height-10);
//            endPoint1 = CGPointMake(self.frame.size.width-15, innerRect.origin.y+innerRect.size.height-10);
//            endPoint2 = CGPointMake(self.frame.size.width-15, innerRect.origin.y+innerRect.size.height-20);
//            centerPoint1 = CGPointMake(self.frame.size.width-7.5, innerRect.origin.y+innerRect.size.height);
//            centerPoint2 = CGPointMake(self.frame.size.width-7.5, innerRect.origin.y+innerRect.size.height-5);
//        }
//            break;
//
//        default:{
//
//            startPoint = CGPointMake(0, innerRect.origin.y+10);
//            endPoint1 = CGPointMake(15, innerRect.origin.y+10);
//            endPoint2 = CGPointMake(15, innerRect.origin.y+20);
//            centerPoint1 = CGPointMake(7.5, innerRect.origin.y);
//            centerPoint2 = CGPointMake(7.5, innerRect.origin.y+5);
//
//        }
//            break;
//    }
//
//
//    UIBezierPath *arrowPath1 = [UIBezierPath bezierPath];
//    [arrowPath1 moveToPoint:startPoint];
//    [arrowPath1 addQuadCurveToPoint:endPoint1 controlPoint:centerPoint1];
//
//    // drawing border for arrowPath1
//    if ([WSChatBubbleView sharedInstance].borderColor) {
//        [arrowPath1 setLineWidth:1.0];
//        [[UIColor lightGrayColor] setStroke];
//        [arrowPath1 stroke];
//    }
//
//
//    UIBezierPath *arrowPath2 = [UIBezierPath bezierPath];
//    [arrowPath2 moveToPoint:startPoint];
//    [arrowPath2 addQuadCurveToPoint:endPoint2 controlPoint:centerPoint2];
//
//    // drawing border for arrowPath2
//    if ([WSChatBubbleView sharedInstance].borderColor) {
//        [arrowPath2 setLineWidth:1.0];
//        [[UIColor redColor] setStroke];
//        [arrowPath2 stroke];
//    }
//
//    [arrowPath1 appendPath:arrowPath2];
//    [arrowPath1 addLineToPoint:endPoint1];
//    [self.backColor setFill];
//
//    [arrowPath1 addClip];
//    [arrowPath1 setUsesEvenOddFillRule:YES];
//    [arrowPath1 fill];
//    [arrowPath1 setUsesEvenOddFillRule:NO];
}

- (void) drawString: (NSString*) s
           withFont: (UIFont*) font
             inRect: (CGRect) contextRect{
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGRect textRect = [self.message boundingRectWithSize:CGSizeMake(contextRect.size.width-20, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attributes
                                                 context:nil];
    
    
    float heightRatio = contextRect.size.height - textRect.size.height;
    
    
    CGRect textRect1 = CGRectMake(contextRect.origin.x+10, contextRect.origin.y+heightRatio/2, contextRect.size.width-20, contextRect.size.height-heightRatio);
    
    
    [s drawInRect:textRect1 withAttributes:attributes];
}

-(void)reloadView{
    [self setNeedsDisplay];
}

-(CGFloat)heightForMessage:(NSString *)msg containerWidth:(CGFloat)width{
    
    if (!self.font) {
        self.font = [UIFont fontWithName:@"Arial" size:14];
    }
    
    CGFloat textContainerWidth = width-width*0.30;
    if (self.image) {
        textContainerWidth = 220;
    }
    
    NSDictionary *attributes = @{NSFontAttributeName: self.font};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
    CGRect textRect = [msg boundingRectWithSize:CGSizeMake(textContainerWidth, CGFLOAT_MAX)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:attributes
                                        context:nil];
    
    CGFloat minimumHeight = 50.0;
    minimumHeight = minimumHeight + textRect.size.height;
    return minimumHeight;
}


@end
