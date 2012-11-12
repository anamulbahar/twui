/*
 Copyright 2011 Twitter, Inc.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this work except in compliance with the License.
 You may obtain a copy of the License in the LICENSE file, or at:
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "TUITextStorage.h"
#import "NSShadow+TUIExtensions.h"

NSString *const TUITextStorageBackgroundColorAttributeName = @"TUITextStorageBackgroundColorAttributeName";
NSString *const TUITextStorageBackgroundFillStyleName = @"TUITextStorageBackgroundFillStyleName";
NSString *const TUITextStoragePreDrawBlockName = @"TUITextStoragePreDrawBlockName";

// This allows TUITextStorage to "seem" like a class cluster, as long
// as we don't override any existing methods in NSMutableAttributedString.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@interface NSMutableAttributedString (TUITextStorage)
@end

@implementation TUITextStorage

+ (TUITextStorage *)storageWithString:(NSString *)string {
	return (TUITextStorage *)[[NSMutableAttributedString alloc] initWithString:string ?: @""];
}

@end

@implementation NSMutableAttributedString (TUITextStorage)

- (NSRange)stringRange {
	return (NSRange) {
		.length = self.length
	};
}

- (void)setText:(NSString *)text {
	[self beginEditing];
	[self replaceCharactersInRange:self.stringRange withString:text ? [text copy] : @""];
	[self endEditing];
}

- (NSString *)text {
	return self.string;
}

- (void)setFont:(NSFont *)font inRange:(NSRange)range {
	if (font != nil)
		[self addAttribute:(id)kCTFontAttributeName value:font range:range];
	else
		[self removeAttribute:(id)kCTFontAttributeName range:range];
}

- (void)setFont:(NSFont *)font {
	[self setFont:font inRange:self.stringRange];
}

- (void)setColor:(NSColor *)color inRange:(NSRange)range {
	[self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void)setColor:(NSColor *)color {
	[self setColor:color inRange:self.stringRange];
}

- (void)setShadow:(NSShadow *)shadow inRange:(NSRange)range {
	[self addAttribute:NSShadowAttributeName value:shadow range:range];
}

- (void)setShadow:(NSShadow *)shadow {
	[self setShadow:shadow inRange:self.stringRange];
}

- (void)setKerning:(CGFloat)k inRange:(NSRange)range {
	[self addAttribute:(NSString *)kCTKernAttributeName value:@(k) range:range];
}

- (void)setKerning:(CGFloat)f {
	[self setKerning:f inRange:self.stringRange];
}

- (void)setBackgroundColor:(NSColor *)color inRange:(NSRange)range {
	[self addAttribute:TUITextStorageBackgroundColorAttributeName value:color range:range];
}

- (void)setBackgroundColor:(NSColor *)color {
	[self setBackgroundColor:color inRange:self.stringRange];
}

- (void)setBackgroundFillStyle:(TUIBackgroundFillStyle)fillStyle inRange:(NSRange)range {
	[self addAttribute:TUITextStorageBackgroundFillStyleName value:@(fillStyle) range:range];
}

- (void)setBackgroundFillStyle:(TUIBackgroundFillStyle)fillStyle {
	[self setBackgroundFillStyle:fillStyle inRange:self.stringRange];
}

- (void)setPreDrawBlock:(TUITextStoragePreDrawBlock)block inRange:(NSRange)range {
	[self addAttribute:TUITextStoragePreDrawBlockName value:[block copy] range:range];
}

- (void)setPreDrawBlock:(TUITextStoragePreDrawBlock)block {
	[self setPreDrawBlock:block inRange:self.stringRange];
}

- (void)setLineHeight:(CGFloat)f inRange:(NSRange)range {
	CTParagraphStyleSetting settings[] = {
        { kCTParagraphStyleSpecifierMinimumLineHeight, sizeof(f), &f },
        { kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(f), &f },
    };
	
	CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, sizeof(settings) / sizeof(settings[0]));
	[self addAttributes:@{ (id)kCTParagraphStyleAttributeName : (__bridge_transfer id)paragraphStyle } range:range];
	CFRelease(paragraphStyle);
}

- (void)setLineHeight:(CGFloat)f {
	[self setLineHeight:f inRange:self.stringRange];
}

- (void)setAlignment:(TUITextAlignment)alignment lineBreakMode:(TUILineBreakMode)lineBreakMode {
	CTLineBreakMode nativeLineBreakMode;
	switch (lineBreakMode) {
		case TUILineBreakModeHeadTruncation:
			nativeLineBreakMode = kCTLineBreakByTruncatingHead;
			break;
		case TUILineBreakModeTailTruncation:
			nativeLineBreakMode = kCTLineBreakByTruncatingTail;
			break;
		case TUILineBreakModeMiddleTruncation:
			nativeLineBreakMode = kCTLineBreakByTruncatingMiddle;
			break;
		case TUILineBreakModeWordWrap:
			nativeLineBreakMode = kCTLineBreakByWordWrapping;
			break;
		case TUILineBreakModeCharacterWrap:
			nativeLineBreakMode = kCTLineBreakByCharWrapping;
			break;
		case TUILineBreakModeClip:
		default:
			nativeLineBreakMode = kCTLineBreakByClipping;
			break;
	}
	
	CTTextAlignment nativeTextAlignment;
	switch (alignment) {
		case TUITextAlignmentRight:
			nativeTextAlignment = kCTRightTextAlignment;
			break;
		case TUITextAlignmentCenter:
			nativeTextAlignment = kCTCenterTextAlignment;
			break;
		case TUITextAlignmentJustified:
			nativeTextAlignment = kCTJustifiedTextAlignment;
			break;
		case TUITextAlignmentLeft:
		default:
			nativeTextAlignment = kCTLeftTextAlignment;
			break;
	}
	
	CTParagraphStyleSetting settings[] = {
		kCTParagraphStyleSpecifierLineBreakMode, sizeof(CTLineBreakMode), &nativeLineBreakMode,
		kCTParagraphStyleSpecifierAlignment, sizeof(CTTextAlignment), &nativeTextAlignment,
	};
	
	CTParagraphStyleRef p = CTParagraphStyleCreate(settings, 2);
	[self addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge_transfer id)p range:self.stringRange];
}

- (void)setAlignment:(TUITextAlignment)alignment {
	[self setAlignment:alignment lineBreakMode:TUILineBreakModeClip];
}

- (void)setLineBreakMode:(TUITextAlignment)lineBreakMode {
	[self setAlignment:TUITextAlignmentLeft lineBreakMode:lineBreakMode];
}

- (NSFont *)font {
	return nil;
}

- (CGFloat)kerning {
	return 0.0;
}

- (CGFloat)lineHeight {
	return 0.0;
}

- (NSShadow *)shadow {
	return nil;
}

- (NSColor *)color {
	return nil;
}

- (NSColor *)backgroundColor {
	return nil;
}

- (TUITextAlignment)alignment {
	return TUITextAlignmentLeft;
}

- (TUITextStoragePreDrawBlock)preDrawBlock {
	return nil;
}

- (TUIBackgroundFillStyle)backgroundFillStyle {
	return TUIBackgroundFillStyleInline;
}

@end
#pragma clang diagnostic pop

@implementation TUITextStorageAutocorrectedPair

- (BOOL)isEqual:(id)object {
	if(![object isKindOfClass:[TUITextStorageAutocorrectedPair class]]) return NO;
	
	TUITextStorageAutocorrectedPair *otherPair = object;
	return [self.originalString isEqualToString:otherPair.originalString] && NSEqualRanges(self.correctionResult.range, otherPair.correctionResult.range);
}

- (NSUInteger)hash {
	return [self.originalString hash] ^ self.correctionResult.range.location ^ self.correctionResult.range.length;
}

- (id)copyWithZone:(NSZone *)zone {
	TUITextStorageAutocorrectedPair *copiedPair = [[[self class] alloc] init];
	copiedPair.correctionResult = self.correctionResult;
	copiedPair.originalString = self.originalString;
	return copiedPair;
}

@end

NSParagraphStyle *NSSParagraphStyleForTUITextAlignment(TUITextAlignment alignment) {
	NSTextAlignment a = NSLeftTextAlignment;
	switch (alignment) {
		case TUITextAlignmentRight:
			a = NSRightTextAlignment;
			break;
		case TUITextAlignmentCenter:
			a = NSCenterTextAlignment;
			break;
		case TUITextAlignmentJustified:
			a = NSJustifiedTextAlignment;
			break;
		case TUITextAlignmentLeft:
		default:
			a = NSLeftTextAlignment;
			break;
	}
	
	NSMutableParagraphStyle *p = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
	p.alignment = a;
	return p;
}
