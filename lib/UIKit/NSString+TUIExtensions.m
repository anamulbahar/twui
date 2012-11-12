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

#import "NSString+TUIExtensions.h"
#import "NSAttributedString+TUIExtensions.h"
#import "TUICGAdditions.h"

@implementation NSString (TUIExtensions)

#pragma mark -
#pragma mark Sizing

- (CGSize)sizeWithFont:(NSFont *)font {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	
	return [s size];
}

- (CGSize)sizeWithFont:(NSFont *)font forWidth:(CGFloat)width {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	
	return [s sizeConstrainedToWidth:width];
}

- (CGSize)sizeWithFont:(NSFont *)font constrainedToSize:(CGSize)size {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	
	return [s sizeConstrainedToSize:size];
}

- (CGSize)sizeWithFont:(NSFont *)font forWidth:(CGFloat)width lineBreakMode:(TUILineBreakMode)lineBreakMode {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	s.lineBreakMode = lineBreakMode;
	
	return [s sizeConstrainedToWidth:width];
}

- (CGSize)sizeWithFont:(NSFont *)font constrainedToSize:(CGSize)size lineBreakMode:(TUILineBreakMode)lineBreakMode {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	s.lineBreakMode = lineBreakMode;
	
	return [s sizeConstrainedToSize:size];
}

#pragma mark -
#pragma mark Drawing

- (CGSize)drawInRect:(CGRect)rect withFont:(NSFont *)font {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	
	[s addAttribute:(id)kCTForegroundColorFromContextAttributeName value:@(YES) range:NSMakeRange(0, self.length)];
	return [s drawInRect:rect];
}

- (CGSize)drawAtPoint:(CGPoint)point withFont:(NSFont *)font {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	
	[s addAttribute:(id)kCTForegroundColorFromContextAttributeName value:@(YES) range:NSMakeRange(0, self.length)];
	return [s drawAtPoint:point];
}

- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width
			 withFont:(NSFont *)font lineBreakMode:(TUILineBreakMode)lineBreakMode {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	s.lineBreakMode = lineBreakMode;
	
	[s addAttribute:(id)kCTForegroundColorFromContextAttributeName value:@(YES) range:NSMakeRange(0, self.length)];
	return [s drawAtPoint:point forWidth:width];
}

- (CGSize)drawInRect:(CGRect)rect withFont:(NSFont *)font lineBreakMode:(TUILineBreakMode)lineBreakMode {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	s.lineBreakMode = lineBreakMode;
	
	[s addAttribute:(id)kCTForegroundColorFromContextAttributeName value:@(YES) range:NSMakeRange(0, self.length)];
	return [s drawInRect:rect];
}

- (CGSize)drawInRect:(CGRect)rect withFont:(NSFont *)font
	   lineBreakMode:(TUILineBreakMode)lineBreakMode alignment:(TUITextAlignment)alignment {
	TUITextStorage *s = [TUITextStorage storageWithString:self];
	
	s.font = font;
	[s setAlignment:alignment lineBreakMode:lineBreakMode];
	
	[s addAttribute:(id)kCTForegroundColorFromContextAttributeName value:@(YES) range:NSMakeRange(0, self.length)];
	return [s drawInRect:rect];
}

#pragma mark -

@end