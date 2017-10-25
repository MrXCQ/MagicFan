/*
 
 Erica Sadun, http://ericasadun.com
 
 */

@import Foundation;
@import CoreText;
@import UIKit;
@import QuartzCore;

#import "Drawing-Text.h"

// Sizing
NSArray *WidthArrayForStringWithFont(NSString *string, UIFont *font);

// Drawing
void DrawStringInRect(NSString *string, CGRect rect, UIFont *font, NSTextAlignment alignment, UIColor *color);
void DrawWrappedStringInRect(NSString *string, CGRect rect, NSString *fontFace, NSTextAlignment alignment, UIColor *color);
void DrawUnwrappedStringInRect(NSString *string, CGRect rect, NSString *fontFace, NSTextAlignment alignment, UIColor *color);
void DrawStringCenteredInRect(NSString *string, UIFont *font, CGRect rect);

UIFont *FontForWrappedString(NSString *string, NSString *fontFace, CGRect rect, CGFloat tolerance);
