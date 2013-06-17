// The MIT License (MIT)
//
// Copyright (c) 2013 Lisovoy Ivan, Denis Kotenko, Yaroslav Bulda
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSString+CKFlipped.h"

static NSDictionary *table = nil;

@implementation NSString (CKFlipped)

// -------------------------------------------------------------------------------

- (NSDictionary *) substitutionTable {
    if (!table) {
        table = @{
                 @"a" : @"\u0250", @"\u0250" : @"a",
                 @"b" : @"q", @"q" : @"b",
                 @"c" : @"\u0254", @"\u0254" : @"c",
                 @"d" : @"p",  @"p" : @"d",
                 @"e" : @"\u01DD", @"\u01DD" : @"e",
                 @"f" : @"\u025f", @"\u025f" : @"f",
                 @"g" : @"\u0253", @"\u0253" : @"g",
                 @"h" : @"\u0265", @"\u0265" : @"h",
                 @"i" : @"\u0131", @"\u0131" : @"i",
                 @"j" : @"\u027e", @"\u027e" : @"j",
                 @"k" : @"\u029e", @"\u029e" : @"k",
                 @"l" : @"ן", @"ן" : @"l",
                 @"m" : @"\u026f", @"\u026f" : @"m",
                 @"n" : @"u", @"u" : @"n",
                 @"o" : @"o", @"o" : @"o",
                 @"p" : @"d", @"d" : @"p",
                 @"q" : @"b", @"b" : @"q",
                 @"r" : @"\u0279", @"\u0279" : @"r",
                 @"s" : @"s", @"s" : @"s",
                 @"t" : @"\u0287", @"\u0287" : @"t",
                 @"u" : @"n", @"n" : @"u",
                 @"v" : @"\u028c", @"\u028c" : @"v",
                 @"w" : @"\u028d", @"\u028d" : @"w",
                 @"x" : @"x", @"x" : @"x",
                 @"y" : @"\u028e", @"\u028e" : @"y",
                 @"." : @"\u02d9", @"\u02d9" : @".",
                 @"," : @"'", @"'" : @",",
                 @"?" : @"\u00bf", @"\u00bf" : @"?",
                 @"!" : @"\u00a1", @"\u00a1" : @"!",
                 };
    }
    
    return table;
}

// -------------------------------------------------------------------------------

- (NSString *) flipped {
    NSMutableString *flipped = [NSMutableString stringWithCapacity:self.length];
    
    @try {
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
            options:NSStringEnumerationByComposedCharacterSequences
            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                NSString *appendChar = substring;
                @try {
                    appendChar = [[self substitutionTable] objectForKey:[substring lowercaseString]];
                    [flipped appendString:appendChar];
                }
                @catch (NSException *exception) {
                    appendChar = [substring lowercaseString];
                    [flipped appendString:appendChar];
                }
            }];
        
        return flipped;
    }
    @catch (NSException *exception) {
        return self;
    }
}

// -------------------------------------------------------------------------------

@end
