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

#import <Foundation/Foundation.h>

extern NSString *const TUITextStorageBackgroundColorAttributeName;
extern NSString *const TUITextStorageBackgroundFillStyleName;
extern NSString *const TUITextStoragePreDrawBlockName;

typedef void (^TUITextStoragePreDrawBlock)(NSAttributedString *attributedString, NSRange substringRange,
										   CGRect rects[], CFIndex rectCount);

typedef enum {
	TUILineBreakModeHeadTruncation,
	TUILineBreakModeTailTruncation,
	TUILineBreakModeMiddleTruncation,
	TUILineBreakModeWordWrap,
	TUILineBreakModeCharacterWrap,
	TUILineBreakModeClip,
} TUILineBreakMode;

typedef enum {
	TUITextAlignmentLeft,
	TUITextAlignmentCenter,
	TUITextAlignmentRight,
	TUITextAlignmentJustified,
} TUITextAlignment;

typedef enum {
	TUITextVerticalAlignmentTop,
	TUITextVerticalAlignmentMiddle,
	TUITextVerticalAlignmentBottom,
} TUITextVerticalAlignment;

typedef enum {
	TUIBackgroundFillStyleInline,
	TUIBackgroundFillStyleBlock,
} TUIBackgroundFillStyle;

typedef enum {
	TUITextSelectionAffinityCharacter = 0,
	TUITextSelectionAffinityWord = 1,
	TUITextSelectionAffinityLine = 2,
	TUITextSelectionAffinityParagraph = 3,
} TUITextSelectionAffinity;

@interface TUITextStorageAutocorrectedPair : NSObject <NSCopying>

@property (nonatomic, strong) NSTextCheckingResult *correctionResult;
@property (nonatomic, copy) NSString *originalString;

@end

@interface TUITextStorage : NSMutableAttributedString

@property (nonatomic, copy) NSString *text;

// The following are write-only properties, and reading them will return nil.
@property (nonatomic, strong) NSFont *font;
@property (nonatomic, assign) CGFloat kerning;
@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, strong) NSShadow *shadow;
@property (nonatomic, strong) NSColor *color;
@property (nonatomic, strong) NSColor *backgroundColor;
@property (nonatomic, copy) TUITextStoragePreDrawBlock preDrawBlock;
@property (nonatomic, assign) TUIBackgroundFillStyle backgroundFillStyle;

// Use -[TUITextStorage setAlignment:lineBreakMode:] for more control.
// Setting this will set lineBreakMode to TUILineBreakModeClip.
// Setting lineBreakMode will set alignment to TUITextAlignmentLeft.
@property (nonatomic, assign) TUITextAlignment alignment;
@property (nonatomic, assign) TUITextAlignment lineBreakMode;

+ (TUITextStorage *)storageWithString:(NSString *)string;

- (NSRange)stringRange;

- (void)setFont:(NSFont *)font inRange:(NSRange)range;
- (void)setKerning:(CGFloat)f inRange:(NSRange)range;
- (void)setLineHeight:(CGFloat)f inRange:(NSRange)range;
- (void)setShadow:(NSShadow *)shadow inRange:(NSRange)range;
- (void)setTextColor:(NSColor *)color inRange:(NSRange)range;
- (void)setBackgroundColor:(NSColor *)color inRange:(NSRange)range;

- (void)setAlignment:(TUITextAlignment)alignment lineBreakMode:(TUILineBreakMode)lineBreakMode;

// The pre-draw block is called before the text or text background has been drawn.
- (void)setPreDrawBlock:(TUITextStoragePreDrawBlock)block inRange:(NSRange)range;
- (void)setBackgroundFillStyle:(TUIBackgroundFillStyle)fillStyle inRange:(NSRange)range;

@end

extern NSParagraphStyle* NSSParagraphStyleForTUITextAlignment(TUITextAlignment alignment);
