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

#import "ExampleScrollView.h"

@implementation ExampleScrollView

- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame])) {
		self.backgroundColor = [NSColor colorWithCalibratedWhite:0.9 alpha:1.0];
		
		self.textField = [[TUITextField alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
		self.textField.layoutName = @"textField";
		self.textField.backgroundColor = [NSColor clearColor];
		self.textField.textColor = [NSColor darkGrayColor];
		self.textField.cursorColor = [NSColor darkGrayColor];
		self.textField.font = [NSFont systemFontOfSize:12.0f];
		self.textField.contentInset = TUIEdgeInsetsMake(2, 2, 2, 2);
		self.textField.autocorrectionEnabled = YES;
		self.textField.spellCheckingEnabled = YES;
		self.textField.placeholder = @"textField";
		self.textField.renderer.verticalAlignment = TUITextVerticalAlignmentMiddle;
		self.textField.renderer.shadowColor = [NSColor whiteColor];
		self.textField.renderer.shadowOffset = CGSizeMake(0, 1);
		self.textField.renderer.shadowBlur = 1.0f;
		self.textField.placeholderRenderer.verticalAlignment = TUITextVerticalAlignmentMiddle;
		self.textField.placeholderRenderer.shadowColor = [NSColor whiteColor];
		self.textField.placeholderRenderer.shadowOffset = CGSizeMake(0, 1);
		self.textField.placeholderRenderer.shadowBlur = 1.0f;
		[self addSubview:self.textField];
		
		self.textView = [[TUITextView alloc] initWithFrame:CGRectMake(0, 0, 22, 22)];
		self.textView.layoutName = @"textView";
		self.textView.backgroundColor = [NSColor clearColor];
		self.textView.textColor = [NSColor darkGrayColor];
		self.textView.cursorColor = [NSColor darkGrayColor];
		self.textView.font = [NSFont systemFontOfSize:12.0f];
		self.textView.contentInset = TUIEdgeInsetsMake(2, 2, 2, 2);
		self.textView.autocorrectionEnabled = YES;
		self.textView.spellCheckingEnabled = YES;
		self.textView.placeholder = @"textView";
		self.textView.renderer.shadowColor = [NSColor whiteColor];
		self.textView.renderer.shadowOffset = CGSizeMake(0, 1);
		self.textView.renderer.shadowBlur = 1.0f;
		self.textView.placeholderRenderer.shadowColor = [NSColor whiteColor];
		self.textView.placeholderRenderer.shadowOffset = CGSizeMake(0, 1);
		self.textView.placeholderRenderer.shadowBlur = 1.0f;
		[self addSubview:self.textView];
		
		CGFloat padding = 5.0f;
		[self.textField addLayoutConstraint:[TUILayoutConstraint constraintWithAttribute:TUILayoutConstraintAttributeMinX
																			  relativeTo:@"superview"
																			   attribute:TUILayoutConstraintAttributeMinX
																				  offset:padding]];
		[self.textField addLayoutConstraint:[TUILayoutConstraint constraintWithAttribute:TUILayoutConstraintAttributeMinY
																			  relativeTo:@"superview"
																			   attribute:TUILayoutConstraintAttributeMinY
																				  offset:padding]];
		[self.textField addLayoutConstraint:[TUILayoutConstraint constraintWithAttribute:TUILayoutConstraintAttributeWidth
																			  relativeTo:@"superview"
																			   attribute:TUILayoutConstraintAttributeWidth
																				  offset:-(padding * 2)]];
		
		[self.textView addLayoutConstraint:[TUILayoutConstraint constraintWithAttribute:TUILayoutConstraintAttributeMinX
																			 relativeTo:@"textField"
																			  attribute:TUILayoutConstraintAttributeMinX]];
		[self.textView addLayoutConstraint:[TUILayoutConstraint constraintWithAttribute:TUILayoutConstraintAttributeMinY
																			 relativeTo:@"textField"
																			  attribute:TUILayoutConstraintAttributeMaxY
																				 offset:padding]];
		[self.textView addLayoutConstraint:[TUILayoutConstraint constraintWithAttribute:TUILayoutConstraintAttributeWidth
																			 relativeTo:@"textField"
																			  attribute:TUILayoutConstraintAttributeWidth]];
		[self.textView addLayoutConstraint:[TUILayoutConstraint constraintWithAttribute:TUILayoutConstraintAttributeHeight
																			 relativeTo:@"superview"
																			  attribute:TUILayoutConstraintAttributeHeight
																				 offset:-((padding * 3) + 22.0f)]];
		
		//_scrollView = [[TUIScrollView alloc] initWithFrame:self.bounds];
		//_scrollView.autoresizingMask = TUIViewAutoresizingFlexibleSize;
		//_scrollView.scrollIndicatorStyle = TUIScrollViewIndicatorStyleDefault;
		//[self addSubview:_scrollView];
		
		//TUIImageView *imageView = [[TUIImageView alloc] initWithImage:[NSImage imageNamed:@"large-image.jpeg"]];
		//[_scrollView addSubview:imageView];
		//[_scrollView setContentSize:imageView.frame.size];
		
	}
	return self;
}


@end
