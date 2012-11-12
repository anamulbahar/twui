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

@interface NSAttributedString (TUIExtensions)

- (CGSize)size;
- (CGSize)sizeConstrainedToSize:(CGSize)size;
- (CGSize)sizeConstrainedToWidth:(CGFloat)width;

- (CGSize)drawInRect:(CGRect)rect;
- (CGSize)drawInRect:(CGRect)rect context:(CGContextRef)ctx;

- (CGSize)drawAtPoint:(CGPoint)point;
- (CGSize)drawAtPoint:(CGPoint)point context:(CGContextRef)ctx;

- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width;
- (CGSize)drawAtPoint:(CGPoint)point forWidth:(CGFloat)width context:(CGContextRef)ctx;

@end
