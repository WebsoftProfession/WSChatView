//
//  WSChatLabel.m
//  WSChatLabel
//
//  Created by WebsoftProfession on 12/28/17.
//  Copyright © 2017 WebsoftProfession. All rights reserved.
//

#import "WSChatLabel.h"
#import "WSChatBubbleView.h"

@interface WSChatLabel()

@end

@implementation WSChatLabel



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    
    if(self.arrowDirectionStyle==ArrowDirectionRightTop || self.arrowDirectionStyle==ArrowDirectionRightBottom){
        self.isSender = true;
        self.frame = CGRectMake(self.superview.frame.size.width-20-rect.size.width, rect.origin.y, rect.size.width, rect.size.height);
    }
    else{
        self.isSender = false;
        self.frame = CGRectMake(rect.origin.x+20, rect.origin.y, rect.size.width, rect.size.height);
    }
    
    rect = self.frame;
    CGRect innerRect = CGRectMake(10, 10, rect.size.width-20, rect.size.height-20);
    
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRoundedRect:innerRect cornerRadius:5.0];
    
    [self.backColor setFill];
    [rectPath fill];
    
    
    [self drawMessage:self.message];
    if (self.image) {
        [self drawImageInRect:innerRect];
    }
    
    // header path
    UIBezierPath *headerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(innerRect.origin.x+5, innerRect.origin.y+2, innerRect.size.width-10, 10) cornerRadius:5.0];
    [self drawHeaderFooterString:self.headerText inRect:headerPath.bounds isHeader:true];
    
    // footer path for time & view
    
    
    
    UIBezierPath *footerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(innerRect.origin.x+10, innerRect.size.height-2, innerRect.size.width-20, 10) cornerRadius:5.0];
    [self drawHeaderFooterString:self.footerText inRect:footerPath.bounds isHeader:false];

    if (self.isSender && self.isDrawStatus) {
        [self drawStatusInRect:footerPath.bounds];
    }
    
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint1 = CGPointZero;
    CGPoint endPoint2 = CGPointZero;
    CGPoint centerPoint1 = CGPointZero;
    CGPoint centerPoint2 = CGPointZero;
    
    
    // drawing border for rectPath
    if ([WSChatBubbleView sharedInstance].borderColor) {
        [rectPath setLineWidth:1.0];
        [[UIColor lightGrayColor] setStroke];
        [rectPath stroke];
    }
    
    switch (self.arrowDirectionStyle) {
        case ArrowDirectionLeftBottom:
        {
            startPoint = CGPointMake(0, innerRect.origin.y+innerRect.size.height-10);
            endPoint1 = CGPointMake(15, innerRect.origin.y+innerRect.size.height-10);
            endPoint2 = CGPointMake(15, innerRect.origin.y+innerRect.size.height-20);
            centerPoint1 = CGPointMake(7.5, innerRect.origin.y+innerRect.size.height);
            centerPoint2 = CGPointMake(7.5, innerRect.origin.y+innerRect.size.height-5);
        }
            break;
        case ArrowDirectionRightTop:
        {
            startPoint = CGPointMake(rect.size.width, innerRect.origin.y+10);
            endPoint1 = CGPointMake(rect.size.width-15, innerRect.origin.y+10);
            endPoint2 = CGPointMake(rect.size.width-15, innerRect.origin.y+20);
            centerPoint1 = CGPointMake(rect.size.width-7.5, innerRect.origin.y);
            centerPoint2 = CGPointMake(rect.size.width-7.5, innerRect.origin.y+5);
        }
            break;
        case ArrowDirectionRightBottom:
        {
            startPoint = CGPointMake(rect.size.width, innerRect.origin.y+innerRect.size.height-10);
            endPoint1 = CGPointMake(rect.size.width-15, innerRect.origin.y+innerRect.size.height-10);
            endPoint2 = CGPointMake(rect.size.width-15, innerRect.origin.y+innerRect.size.height-20);
            centerPoint1 = CGPointMake(rect.size.width-7.5, innerRect.origin.y+innerRect.size.height);
            centerPoint2 = CGPointMake(rect.size.width-7.5, innerRect.origin.y+innerRect.size.height-5);
        }
            break;
            
        default:{
            
            startPoint = CGPointMake(0, innerRect.origin.y+10);
            endPoint1 = CGPointMake(15, innerRect.origin.y+10);
            endPoint2 = CGPointMake(15, innerRect.origin.y+20);
            centerPoint1 = CGPointMake(7.5, innerRect.origin.y);
            centerPoint2 = CGPointMake(7.5, innerRect.origin.y+5);
            
        }
            break;
    }
    
    
    UIBezierPath *arrowPath1 = [UIBezierPath bezierPath];
    [arrowPath1 moveToPoint:startPoint];
    [arrowPath1 addQuadCurveToPoint:endPoint1 controlPoint:centerPoint1];
    
    // drawing border for arrowPath1
    if ([WSChatBubbleView sharedInstance].borderColor) {
        [arrowPath1 setLineWidth:1.0];
        [[UIColor lightGrayColor] setStroke];
        [arrowPath1 stroke];
    }
    
    
    UIBezierPath *arrowPath2 = [UIBezierPath bezierPath];
    [arrowPath2 moveToPoint:startPoint];
    [arrowPath2 addQuadCurveToPoint:endPoint2 controlPoint:centerPoint2];
    
    // drawing border for arrowPath2
    if ([WSChatBubbleView sharedInstance].borderColor) {
        [arrowPath2 setLineWidth:1.0];
        [[UIColor redColor] setStroke];
        [arrowPath2 stroke];
    }
    
    [arrowPath1 appendPath:arrowPath2];
    [arrowPath1 addLineToPoint:endPoint1];
    [self.backColor setFill];
    
    [arrowPath1 addClip];
    [arrowPath1 setUsesEvenOddFillRule:YES];
    [arrowPath1 fill];
    [arrowPath1 setUsesEvenOddFillRule:NO];
    
}

-(void)drawStatusInRect:(CGRect)rect{
    
    
    CGFloat whRatio = 5;
    CGFloat xyRatio = 0;
    if (!self.isSent) {
        whRatio = 8;
        xyRatio = 1;
    }
    
    UIBezierPath *sentPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((rect.origin.x+rect.size.width-xyRatio-18)-whRatio/2, rect.origin.y + rect.size.height/2-whRatio/2, whRatio, whRatio)];
    if (self.sentStatusImage && self.isSent) {
        [[UIImage imageNamed:self.sentStatusImage] drawInRect:sentPath.bounds];
    }
    else{
        [[UIColor darkGrayColor] setFill];
        [sentPath fill];
    }
    

    
    whRatio = 5;
    xyRatio = 0;
    if (self.isDelivered) {
        whRatio = 8;
    }
    UIBezierPath *deliveredPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x+rect.size.width-10-whRatio/2, rect.origin.y + rect.size.height/2-whRatio/2, whRatio, whRatio)];
    if (self.deliveredStatusImage && self.isDelivered) {
        [[UIImage imageNamed:self.deliveredStatusImage] drawInRect:deliveredPath.bounds];
    }
    else{
        [[UIColor greenColor] setFill];
        [deliveredPath fill];
    }
    
    
    whRatio = 5;
    xyRatio = 0;
    if (self.isSeen) {
        whRatio = 8;
        xyRatio = 1;
    }
    
    UIBezierPath *seenPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x+rect.size.width+xyRatio-2-whRatio/2, rect.origin.y + rect.size.height/2-whRatio/2, whRatio, whRatio)];
    if (self.seenStatusImage && self.isSeen) {
        [[UIImage imageNamed:self.seenStatusImage] drawInRect:seenPath.bounds];
    }
    else{
        [[UIColor blueColor] setFill];
        [seenPath fill];
    }
    
}


-(void)drawMessage:(NSString *)message{
    CGRect innerRect = CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height-20);
    self.textHeight = [self getNewTextHeight:innerRect];
    if (self.image) {
        innerRect = CGRectMake(10, 10, innerRect.size.width, self.textHeight+25);
    }
    
//    NSAttributedString *attributedString = [[NSAttributedString alloc]
//                                            initWithData: [self.message dataUsingEncoding:NSUnicodeStringEncoding]
//                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
//                                            documentAttributes: nil
//                                            error: nil
//                                            ];
    
    [self drawString:self.message withFont:self.font inRect:innerRect];
//    [self drawHtmlString:self.message inRect:innerRect];
}

-(void)drawImageInRect:(CGRect)rect {
    CGFloat heightRatio = self.frame.size.height-self.textHeight;
    CGRect centerRect = CGRectMake(rect.origin.x + rect.size.width/2-80, self.textHeight+heightRatio/2-80, 160, 160);
//    CGRect centerRect = CGRectMake(rect.origin.x + rect.size.width/2-80, rect.origin.y+10+(self.frame.size.height-rect.size.height)/2-80, 160, 160);
    [self.image drawInRect:centerRect];
}

-(void)drawHtmlString:(NSString *)s inRect:(CGRect)contextRect{
    CGRect textRect = [self.message boundingRectWithSize:CGSizeMake(contextRect.size.width-20, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                 context:nil];
    
    float heightRatio = contextRect.size.height - textRect.size.height;
    if(heightRatio<0){
        heightRatio = heightRatio * (-1);
    }
    
    CGRect textRect1 = CGRectMake(contextRect.origin.x+10, contextRect.origin.y+heightRatio/2, contextRect.size.width-20, contextRect.size.height-heightRatio);
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[self.message dataUsingEncoding:NSUTF8StringEncoding]
                                                                            options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                      NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                 documentAttributes:nil error:nil];
    [attributedString drawInRect:textRect1];
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
    if (!self.textColor) {
        self.textColor = [UIColor blackColor];
    }
    
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: self.textColor,
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGRect textRect = [self.message boundingRectWithSize:CGSizeMake(contextRect.size.width-20, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attributes
                                                 context:nil];
    
    float heightRatio = contextRect.size.height - textRect.size.height;
    if(heightRatio<0){
        heightRatio = heightRatio * (-1);
    }
    
    CGRect textRect1 = CGRectMake(contextRect.origin.x+10, contextRect.origin.y+heightRatio/2, contextRect.size.width-20, contextRect.size.height-heightRatio);
    
    
    [s drawInRect:textRect1 withAttributes:attributes];
}

-(CGFloat)getNewTextHeight:(CGRect)rect{
    // Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    
    NSDictionary *attributes = @{ NSFontAttributeName: self.font,
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGRect textRect = [self.message boundingRectWithSize:CGSizeMake(rect.size.width-20, CGFLOAT_MAX)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attributes
                                                 context:nil];
    return textRect.size.height;
}

-(void)drawHeaderFooterString:(NSString *)string inRect:(CGRect)rect isHeader:(BOOL)isHeader{
    
    
    
    /// Make a copy of the default paragraph style
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentRight;
    UIColor *fontColor;
    if (!self.footerColor) {
        fontColor = [UIColor blackColor];
    }
    else{
        fontColor = self.footerColor;
    }
    
    if (isHeader) {
        paragraphStyle.alignment = NSTextAlignmentLeft;
        if (!self.headerColor) {
            fontColor = [UIColor blueColor];
        }
        else{
            fontColor = self.headerColor;
        }
    }
    
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont fontWithName:self.font.fontName size:10.0],
                                  NSForegroundColorAttributeName: fontColor,
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    if (self.isSender && !isHeader) {
        if (self.isDrawStatus) {
            rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width-30, rect.size.height);
        }
    }
    [string drawInRect:rect withAttributes:attributes];
}


@end
