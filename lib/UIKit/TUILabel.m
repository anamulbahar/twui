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

#import "TUILabel.h"
#import "TUICGAdditions.h"
#import "TUITextRenderer.h"

@implementation TUILabel

- (id)initWithFrame:(CGRect)frame {
	if((self = [super initWithFrame:frame])) {
		_renderer = [[TUITextRenderer alloc] init];
		
		self.renderer.verticalAlignment = TUITextVerticalAlignmentMiddle;
		self.renderer.shadowBlur = 0.0f;
		self.renderer.shadowOffset = CGSizeMake(0, 1);
		
		_lineBreakMode = TUILineBreakModeClip;
		_textAlignment = TUITextAlignmentLeft;
		
		self.minimumFontSize = 4.0f;
		self.numberOfLines = 1;
		
		self.enabled = YES;
		self.clipsToBounds = YES;
		self.userInteractionEnabled = NO;
		self.textRenderers = @[self.renderer];
	}
	return self;
}

- (NSMenu *)menuForEvent:(NSEvent *)event {
	if(!self.enabled)
		return nil;
	
	NSMenu *m = [[NSMenu alloc] initWithTitle:@""]; {
		NSMenuItem *i = [[NSMenuItem alloc] initWithTitle:NSLocalizedString(@"Copy", nil)
												   action:@selector(copyText:) keyEquivalent:@""];
		[i setKeyEquivalent:@"c"];
		[i setKeyEquivalentModifierMask:NSCommandKeyMask];
		[i setTarget:self];
		[m addItem:i];
	}
	
	return m;
}

- (void)copyText:(id)sender {
	if(!self.enabled)
		return;
	
	[[NSPasteboard generalPasteboard] clearContents];
	[[NSPasteboard generalPasteboard] writeObjects:[NSArray arrayWithObjects:self.renderer.selectedString, nil]];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	if(!self.renderer.attributedString)
		[self _recreateAttributedString];
	
	CGContextSetAlpha(TUIGraphicsGetCurrentContext(), self.enabled ? 1.0 : 0.7);
	self.renderer.frame = (CGRect) {
		.size = [self.renderer sizeConstrainedToWidth:self.bounds.size.width numberOfLines:self.numberOfLines]
	};
	
	[self.renderer draw];
}

- (TUITextStorage *)attributedString {
	if(!self.renderer.attributedString)
		[self _recreateAttributedString];
	
	return self.renderer.attributedString;
}

- (void)setAttributedString:(TUITextStorage *)a {
	self.renderer.attributedString = a;
	[self setNeedsDisplay];
}

- (void)_recreateAttributedString {
	if(!_text)
		return;
	
	TUITextStorage *newAttributedString = [TUITextStorage storageWithString:_text];
	
	if(self.font)
		newAttributedString.font = self.font;
	if(self.textColor && !self.highlighted)
		newAttributedString.color = self.textColor;
	else if(self.highlightedTextColor && self.highlighted)
		newAttributedString.color = self.highlightedTextColor;
	
	[newAttributedString setAlignment:self.textAlignment lineBreakMode:self.lineBreakMode];
	self.textStorage = newAttributedString;
}

- (void)setText:(NSString *)text {
	if([text isEqualToString:_text])
		return;
	
	_text = [text copy];
	self.textStorage = nil;
	[self setNeedsDisplay];
}

- (void)setFont:(NSFont *)font {
	if([font isEqual:_font])
		return;
	
	_font = font;
	self.textStorage = nil;
	[self setNeedsDisplay];
}

- (void)setTextColor:(NSColor *)textColor {
	if([textColor isEqual:_textColor])
		return;
	
	_textColor = textColor;
	self.textStorage = nil;
	[self setNeedsDisplay];
}

- (void)setAlignment:(TUITextAlignment)alignment {
	if(alignment == _textAlignment)
		return;
	
	_textAlignment = alignment;
	self.textStorage = nil;
	[self setNeedsDisplay];
}

- (void)setLineBreakMode:(TUILineBreakMode)lineBreakMode {
	if (lineBreakMode == _lineBreakMode)
		return;
	
	_lineBreakMode = lineBreakMode;
	self.textStorage = nil;
	[self setNeedsDisplay];
}

- (void)setShadowColor:(NSColor *)shadowColor {
	self.renderer.shadowColor = shadowColor;
	[self setNeedsDisplay];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
	self.renderer.shadowOffset = shadowOffset;
	[self setNeedsDisplay];
}

- (NSColor *)shadowColor {
	return self.renderer.shadowColor;
}

- (CGSize)shadowOffset {
	return self.renderer.shadowOffset;
}

- (void)setEnabled:(BOOL)enabled {
	if(_enabled == enabled)
		return;
	
	_enabled = enabled;
	self.renderer.shouldRefuseFirstResponder = !enabled;
}

- (void)sizeToFit {
	self.frame = (CGRect) {
		.origin = self.frame.origin,
		.size = [self.renderer sizeConstrainedToWidth:self.bounds.size.width numberOfLines:self.numberOfLines]
	};
}

@end
