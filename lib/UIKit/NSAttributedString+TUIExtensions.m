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

#import "NSAttributedString+TUIExtensions.h"
#import "TUITextRenderer.h"
#import "TUICGAdditions.h"

@implementation NSAttributedString (TUIExtensions)

#pragma mark -
#pragma mark Internal

- (TUITextRenderer *)__sharedTextRenderer {
	static TUITextRenderer *renderer = nil;
	if(!renderer)
		renderer = [[TUITextRenderer alloc] init];
	
	return renderer;
}

#pragma mark -
#pragma mark Sizing

- (CGSize)size {
	return [self sizeConstrainedToSize:CGSizeMake(HUGE_VALF, HUGE_VALF)];
}

- (CGSize)sizeConstrainedToWidth:(CGFloat)width {
	return [self sizeConstrainedToSize:CGSizeMake(width, HUGE_VALF)];
}

- (CGSize)sizeConstrainedToSize:(CGSize)size {
	TUITextRenderer *t = [self __sharedTextRenderer];
	
	t.textStorage = (TUITextStorage *)[self mutableCopy];
	t.frame = (CGRect) { .size = size };
	
	return [t size];
}

#pragma mark -
#pragma mark Drawing

- (CGSize)drawInRect:(CGRect)rect {
	return [self drawInRect:rect context:TUIGraphicsGetCurrentContext()];
}

- (CGSize)drawAtPoint:(CGPoint)point {
	return [self drawAtPoint:point context:TUIGraphicsGetCurrentContext()];
}

- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width {
	return [self drawAtPoint:point forWidth:width context:TUIGraphicsGetCurrentContext()];
}

- (CGSize)drawInRect:(CGRect)rect context:(CGContextRef)ctx {
	TUITextRenderer *t = [self __sharedTextRenderer];
	
	t.textStorage = (TUITextStorage *)[self mutableCopy];
	t.frame = rect;
	
	[t drawInContext:ctx];
	return [t size];
}

- (CGSize)drawAtPoint:(CGPoint)point context:(CGContextRef)ctx {
	TUITextRenderer *t = [self __sharedTextRenderer];
	
	t.textStorage = (TUITextStorage *)[self mutableCopy];
	t.frame = (CGRect) {
		.origin = point,
		.size = [t size]
	};
	
	[t drawInContext:ctx];
	return t.frame.size;
}

- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width context:(CGContextRef)ctx {
	TUITextRenderer *t = [self __sharedTextRenderer];
	
	t.textStorage = (TUITextStorage *)[self mutableCopy];
	t.frame = (CGRect) {
		.origin = point,
		.size = [t sizeConstrainedToWidth:width]
	};
	
	[t drawInContext:ctx];
	return t.frame.size;
}

#pragma mark -

@end
