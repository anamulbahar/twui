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
#import "TUITextEditor.h"

@protocol TUITextViewDelegate;

@interface TUITextView : TUIControl

@property (nonatomic, unsafe_unretained) id <TUITextViewDelegate> delegate;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeholder;

@property (nonatomic, strong, readonly) TUITextRenderer *renderer;
@property (nonatomic, strong, readonly) TUITextRenderer *placeholderRenderer;

@property (nonatomic, strong) NSFont *font;
@property (nonatomic, strong) NSColor *textColor;
@property (nonatomic, assign) TUITextAlignment textAlignment;

@property (nonatomic, assign) BOOL clearsOnBeginEditing;

// Dysfunctional.
@property (nonatomic, assign) BOOL adjustsFontSizeToFitWidth;
@property (nonatomic, assign) CGFloat minimumFontSize;

@property (nonatomic, strong) NSColor *cursorColor;
@property (nonatomic, assign) CGFloat cursorWidth;
@property (nonatomic, assign) TUIEdgeInsets contentInset;

@property (nonatomic, assign) NSRange selectedRange;
@property (nonatomic, assign, getter = isEditable) BOOL editable;
@property (nonatomic, assign, getter = isSpellCheckingEnabled) BOOL spellCheckingEnabled;
@property (nonatomic, assign, getter = isAutocorrectionEnabled) BOOL autocorrectionEnabled;

@property (nonatomic, copy) TUIViewDrawRect drawFrame;

- (BOOL)doCommandBySelector:(SEL)selector;

@end

@protocol TUITextViewDelegate <NSObject>

@optional

// return YES if the implementation consumes the selector, NO if it should be passed up to super.
- (BOOL)textView:(TUITextView *)textView doCommandBySelector:(SEL)commandSelector;
- (void)textViewDidChange:(TUITextView *)textView;

- (void)textViewWillBeginEditing:(TUITextView *)textView;
- (void)textViewDidBeginEditing:(TUITextView *)textView;
- (void)textViewWillEndEditing:(TUITextView *)textView;
- (void)textViewDidEndEditing:(TUITextView *)textView;

- (BOOL)textViewShouldReturn:(TUITextView *)textView;
- (BOOL)textViewShouldClear:(TUITextView *)textView;
- (BOOL)textViewShouldTabToNext:(TUITextView *)textView;

@end
