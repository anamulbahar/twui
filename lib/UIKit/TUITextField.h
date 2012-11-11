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

#import "TUIControl.h"
#import "TUIGeometry.h"
#import "TUITextStorage.h"

@class TUITextEditor;
@class TUIButton;
@class NSFont;

@protocol TUITextFieldDelegate;

@interface TUITextField : TUIControl {
	id<TUITextFieldDelegate> __unsafe_unretained delegate;
	TUIViewDrawRect drawFrame;
	
	NSString *placeholder;
	TUITextRenderer *placeholderRenderer;
	
	NSFont *font;
	NSColor *textColor;
	TUITextAlignment textAlignment;
	BOOL editable;
	
	BOOL spellCheckingEnabled;
	NSInteger lastCheckToken;
	NSArray *lastCheckResults;
	NSTextCheckingResult *selectedTextCheckingResult;
	BOOL autocorrectionEnabled;
	NSMutableDictionary *autocorrectedResults;
	
	TUIEdgeInsets contentInset;
	
	TUITextEditor *renderer;
	TUIView *cursor;
	
	CGRect _lastTextRect;
	
	@package
	struct {
		unsigned int delegateTextFieldDidChange:1;
		unsigned int delegateDoCommandBySelector:1;
		unsigned int delegateWillBecomeFirstResponder:1;
		unsigned int delegateDidBecomeFirstResponder:1;
		unsigned int delegateWillResignFirstResponder:1;
		unsigned int delegateDidResignFirstResponder:1;
		unsigned int delegateTextFieldShouldReturn:1;
		unsigned int delegateTextFieldShouldClear:1;
		unsigned int delegateTextFieldShouldTabToNext:1;
	} _textFieldFlags;
}

@property (nonatomic, unsafe_unretained) id<TUITextFieldDelegate> delegate;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) NSFont *font;
@property (nonatomic, strong) NSColor *textColor;
@property (nonatomic, strong) NSColor *cursorColor;
@property (nonatomic, assign) CGFloat cursorWidth;
@property (nonatomic, assign) TUITextAlignment textAlignment;
@property (nonatomic, assign) TUIEdgeInsets contentInset;

@property (nonatomic, assign) NSRange selectedRange;
@property (nonatomic, assign, getter=isEditable) BOOL editable;
@property (nonatomic, assign, getter=isSpellCheckingEnabled) BOOL spellCheckingEnabled;
@property (nonatomic, assign, getter=isAutocorrectionEnabled) BOOL autocorrectionEnabled;

@property (nonatomic, copy) TUIViewDrawRect drawFrame;

- (BOOL)hasText;

- (BOOL)doCommandBySelector:(SEL)selector;

@property (nonatomic, strong) TUIButton *rightButton;

- (TUIButton *)clearButton;

@end

@protocol TUITextFieldDelegate <NSObject>

@optional

- (void)textFieldDidChange:(TUITextField *)textField;
- (BOOL)textField:(TUITextField *)textField doCommandBySelector:(SEL)commandSelector; // return YES if the implementation consumes the selector, NO if it should be passed up to super

- (void)textFieldWillBecomeFirstResponder:(TUITextField *)textField;
- (void)textFieldDidBecomeFirstResponder:(TUITextField *)textField;
- (void)textFieldWillResignFirstResponder:(TUITextField *)textField;
- (void)textFieldDidResignFirstResponder:(TUITextField *)textField;

- (BOOL)textFieldShouldReturn:(TUITextField *)textField;
- (BOOL)textFieldShouldClear:(TUITextField *)textField;
- (BOOL)textFieldShouldTabToNext:(TUITextField *)textField;

@end
