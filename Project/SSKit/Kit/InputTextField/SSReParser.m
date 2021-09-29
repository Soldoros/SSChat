//
//  SSReParser.m
//  MECP
//
//  Created by soldoros on 2021/6/23.
//


#import "SSReParser.h"

// common interface for all node types

@interface SSReNode : NSObject

@property (assign, nonatomic) NSRange sourceRange;
@property (weak, nonatomic) SSReNode *parent;
@property (weak, nonatomic) SSReNode *nextSibling;

- (NSString*)displayString:(NSString*)pattern;

@end

@implementation SSReNode

- (NSString*)displayString:(NSString*)pattern
{
    return [pattern substringWithRange:_sourceRange];
}

@end

// interface for group node

@interface SSReGroup : SSReNode

@property (assign, nonatomic) BOOL capturing;
@property (strong, nonatomic) NSArray *children;

@end

@implementation SSReGroup

- (void)dealloc
{
    _children = nil;
}

- (NSString*)displayString:(NSString*)pattern
{
    return [NSString stringWithFormat:@"(%@)", [pattern substringWithRange:self.sourceRange]];
}

- (NSString*)debugDescription
{
    if (_capturing)
        return @"Capturing Parentheses";
    else
        return @"Non-capturing Parentheses";
}

@end

// interface for alternation node

@interface SSReAlternation : SSReNode

@property (strong, nonatomic) NSArray *children;

@end

@implementation SSReAlternation

- (void)dealloc
{
    _children = nil;
}

- (NSString*)displayString:(NSString*)pattern
{
    return [pattern substringWithRange:self.sourceRange];
}

- (NSString*)debugDescription
{
    return @"Alternation";
}

@end

// interface for quantifier

@interface SSReQuantifier : SSReNode

- (id)initWithFrom:(NSUInteger)from to:(NSUInteger)to;

@property (strong, nonatomic) SSReNode *child;
@property (assign, nonatomic) BOOL greedy;
@property (assign, nonatomic) NSUInteger countFrom;
@property (assign, nonatomic) NSUInteger countTo;

@end

@implementation SSReQuantifier

- (id)init
{
    self = [super init];
    if (self)
    {
        _greedy = YES;
        _countFrom = 1;
        _countTo = 1;
    }
    return self;
}

- (id)initWithFrom:(NSUInteger)from to:(NSUInteger)to
{
    self = [super init];
    if (self)
    {
        _greedy = YES;
        _countFrom = from;
        _countTo = to;
    }
    return self;
}

- (void)dealloc
{
    _child = nil;
}

- (NSString*)debugDescription
{
    if (_greedy)
        return @"Greedy Quantifier";
    else
        return @"Lazy Quantifier";
}

- (NSString*)displayQuantifier
{
    NSString *pat = nil;
    if (_countFrom == 0) {
        if (_countTo == NSUIntegerMax) {
            pat = @"*";
        } else if (_countTo == 1) {
            pat = @"?";
        } else {
            pat = [NSString stringWithFormat:@"{,%lu}", (unsigned long)_countTo];
        }
    } else if (_countFrom == 1 && _countTo == NSUIntegerMax) {
        pat = @"+";
    } else if (_countFrom == _countTo) {
        pat = [NSString stringWithFormat:@"{%lu}", (unsigned long)_countFrom];
    } else if (_countTo == NSUIntegerMax) {
        pat = [NSString stringWithFormat:@"{%lu,}", (unsigned long)_countFrom];
    } else {
        pat = [NSString stringWithFormat:@"{%lu,%lu}", (unsigned long)_countFrom, (unsigned long)_countTo];
    }
    
    if (_greedy) return pat;
    
    return [pat stringByAppendingString:@"?"];
}

- (NSString*)displayString:(NSString *)pattern
{
    return [[_child displayString:pattern] stringByAppendingString:[self displayQuantifier]];
}

@end

// base interface for all character subsets

@interface SSReCharacterBase : SSReNode

@property (assign, nonatomic) BOOL ignoreCase;

- (BOOL)matchesCharacter:(unichar)c;

@end

@implementation SSReCharacterBase

- (BOOL)matchesCharacter:(unichar)c
{
    @throw [NSException exceptionWithName:@"Invalid operation" reason:@"Override this method in subclasses" userInfo:nil];
}

@end

// interface for character set node

@interface SSReCharacterSet : SSReCharacterBase

@property (assign, nonatomic) BOOL negation;
@property (strong, nonatomic) NSCharacterSet *chars;

@end

@implementation SSReCharacterSet

- (BOOL)matchesCharacter:(unichar)c
{
    BOOL contains = [_chars characterIsMember:c];
    
    if (!contains && self.ignoreCase)
    {
        if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c])
        {
            // test upper
            unichar uc = [[[NSString stringWithCharacters:&c length:1] uppercaseString] characterAtIndex: 0];
            contains = [_chars characterIsMember:uc];
        }
        else if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c])
        {
            // test lower
            unichar lc = [[[NSString stringWithCharacters:&c length:1] lowercaseString] characterAtIndex: 0];
            contains = [_chars characterIsMember:lc];
        }
    }
    
    return contains ^ _negation;
}

- (NSString*)displayString:(NSString*)pattern
{
    return [NSString stringWithFormat:@"[%@]", [pattern substringWithRange:self.sourceRange]];
}

- (NSString*)debugDescription
{
    return @"Character Class";
}

@end

// interface for literal node

@interface SSReLiteral : SSReCharacterBase

@property (assign, nonatomic) unichar character;

@end

@implementation SSReLiteral

- (BOOL)matchesCharacter:(unichar)c
{
    BOOL contains = _character == c;
    
    if (!contains && self.ignoreCase)
    {
        if ([[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:c])
        {
            // test upper
            unichar uc = [[[NSString stringWithCharacters:&c length:1] uppercaseString] characterAtIndex: 0];
            contains = _character == uc;
        }
        else if ([[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:c])
        {
            // test lower
            unichar lc = [[[NSString stringWithCharacters:&c length:1] lowercaseString] characterAtIndex: 0];
            contains = _character == lc;
        }
    }
    
    return contains;
}

- (NSString*)displayString:(NSString *)pattern
{
    return [NSString stringWithFormat:@"'%c'", _character];
}

- (NSString*)debugDescription
{
    return @"Character";
}

@end

// interface for any character (.) node

@interface SSReAnyCharacter : SSReCharacterBase

@end

@implementation SSReAnyCharacter

- (BOOL)matchesCharacter:(unichar)c
{
    return YES;
}

- (NSString*)displayString:(NSString*)pattern
{
    return @".";
}

- (NSString*)debugDescription
{
    return @"Any Character";
}

@end

// interface for end of string ($) node

@interface SSReEndOfString : SSReCharacterBase

@end

@implementation SSReEndOfString

- (NSString*)displayString:(NSString *)pattern
{
    return @"$";
}

- (NSString*)debugDescription
{
    return @"End of String";
}

- (BOOL)matchesCharacter:(unichar)c
{
    return c == 0;
}

@end

// helper internal classes

@interface SSState : NSObject
{
    NSMutableArray *_transitions;
}

@property (assign, nonatomic) BOOL isFinal;
@property (readonly, nonatomic) NSMutableArray *transitions;

@end

@implementation SSState

- (NSMutableArray*)transitions
{
    if (_transitions == nil)
        _transitions = [[NSMutableArray alloc] initWithCapacity:1];
    return _transitions;
}

@end

@interface SSTransition : NSObject

@property (weak, nonatomic) SSReCharacterBase *node;
@property (weak, nonatomic) SSReLiteral *bypassNode;
@property (strong, nonatomic) SSState *nextState;

@end

@implementation SSTransition

@end

// parser implementation

@implementation SSReParser

- (id)initWithPattern:(NSString *)pattern
{
    return [self initWithPattern:pattern ignoreCase:NO];
}

- (id)initWithPattern:(NSString *)pattern ignoreCase:(BOOL)ignoreCase
{
    NSParameterAssert(pattern != nil && ![pattern isEqualToString:@""]);
    
    self = [super init];
    if (self)
    {
        _pattern = pattern;
        _ignoreCase = ignoreCase;
        _node = nil;
        [self parsePattern];
    }
    return self;
}

- (void)dealloc
{
    _pattern = nil;
    _node = nil;
    _exactQuantifierRegex = nil;
    _rangeQuantifierRegex = nil;
}

#ifdef DEBUG

- (NSString*)debugDescription
{
    return [self nodeDescription:_node withLevel:0];
}

- (NSString*)nodeDescription:(SSReNode*)node withLevel:(NSUInteger)level
{
    NSMutableString *buffer = [[NSMutableString alloc] initWithCapacity:100];
    
    for (NSUInteger i = 0; i < level; i++)
        [buffer appendString:@"  "];
    
    [buffer appendString:[node displayString:_pattern]];
    [buffer appendString:@" - "];
    [buffer appendString:[node debugDescription]];
    [buffer appendString:@"\n"];
    
    if ([node isKindOfClass:[SSReAlternation class]])
    {
        for (SSReNode* c in [(SSReAlternation*)node children])
            [buffer appendString:[self nodeDescription:c withLevel:level+1]];
    }
    else if ([node isKindOfClass:[SSReGroup class]])
    {
        for (SSReNode* c in [(SSReGroup*)node children])
            [buffer appendString:[self nodeDescription:c withLevel:level+1]];
    }
    else if ([node isKindOfClass:[SSReQuantifier class]])
    {
        [buffer appendString:[self nodeDescription:[(SSReQuantifier*)node child] withLevel:level+1]];
    }

    return buffer;
}

#endif

- (void)parsePattern
{
    if (_node != nil) return;

    if (![_pattern hasPrefix:@"^"])
        @throw [NSException exceptionWithName:@"Error" reason:@"Invalid pattern start" userInfo:nil];
    
    _finished = NO;
    _exactQuantifierRegex = [[NSRegularExpression alloc] initWithPattern:@"^\\{\\s*(\\d+)\\s*\\}$" options:0 error:nil];
    _rangeQuantifierRegex = [[NSRegularExpression alloc] initWithPattern:@"^\\{\\s*(\\d*)\\s*,\\s*(\\d*)\\s*\\}$" options:0 error:nil];
    
    _node = [self parseSubpattern:_pattern inRange:NSMakeRange(1, _pattern.length - 1) enclosed:NO];
    
    _exactQuantifierRegex = nil;
    _rangeQuantifierRegex = nil;
    
    if (!_finished)
        @throw [NSException exceptionWithName:@"Error" reason:@"Invalid pattern end" userInfo:nil];
}

- (BOOL)isValidEscapedChar:(unichar)c inCharset:(BOOL)inCharset
{
    switch (c)
    {
        case '(':
        case ')':
        case '[':
        case ']':
        case '{':
        case '}':
        case '\\':
        case '|':
        case 'd':
        case 'D':
        case 'w':
        case 'W':
        case 's':
        case 'S':
        case 'u':
        case '\'':
        case '.':
        case '+':
        case '*':
        case '?':
        case '$':
        case '^':
            return YES;
            
        case '-':
            return inCharset;
            
        default:
            return NO;
    }
}

- (void)raiseParserError:(NSString*)error atPos:(NSUInteger)pos
{
    NSString *pat = [NSString stringWithFormat:@"%@ \u25B6%@", [_pattern substringToIndex:pos], [_pattern substringFromIndex:pos]];
    @throw [NSException exceptionWithName:@"Parse error" reason:[NSString stringWithFormat:@"%@ @ pos %lu: %@", error, (unsigned long)pos, pat] userInfo:nil];
}

- (SSReCharacterBase*)parseCharset:(NSString*)pattern inRange:(NSRange)range enclosed:(BOOL)enclosed
{
    BOOL negation = NO;
    NSUInteger count = 0;
    unichar lastChar = 0;
    NSMutableCharacterSet *chars = [[NSMutableCharacterSet alloc] init];
    BOOL escape = NO;
    
    for (NSUInteger i = 0; i < range.length; i++) {
        unichar c = [pattern characterAtIndex:(range.location + i)];
        
        if (enclosed && i == 0 && c == '^') {
            negation = YES;
            continue;
        }
        
        if (c == '\\' && !escape) {
            escape = YES;
            continue;
        }
        
        if (escape) {
            // process character classes and escaped special chars
            
            if (![self isValidEscapedChar:c inCharset:enclosed])
                [self raiseParserError:@"Invalid escape sequence" atPos:(range.location + i)];
            
            if (c == 'd') {
                [chars formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
                count += 2;
            }
            else if (c == 'D') {
                [chars formUnionWithCharacterSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]];
                count += 2;
            }
            else if (c == 'w') {
                [chars formUnionWithCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
                count += 2;
            }
            else if (c == 'W') {
                [chars formUnionWithCharacterSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]];
                count += 2;
            }
            else if (c == 's') {
                [chars formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
                count += 2;
            }
            else if (c == 'S') {
                [chars formUnionWithCharacterSet:[[NSCharacterSet whitespaceCharacterSet] invertedSet]];
                count += 2;
            }
            else if (c == 'u') {
                // unicode character in format \uFFFF
                
                if (i + 4 >= range.length)
                    [self raiseParserError:@"Expected a four-digit hexadecimal character code" atPos:(range.location + i + 1)];
                
                NSScanner *scanner = [NSScanner scannerWithString:[pattern substringWithRange:NSMakeRange(range.location + i + 1, 4)]];
                
                unsigned int code;
                if (![scanner scanHexInt:&code])
                    [self raiseParserError:@"Expected a four-digit hexadecimal character code" atPos:(range.location + i + 1)];
                
                lastChar = (unichar)code;
                [chars addCharactersInRange:NSMakeRange(lastChar, 1)];
                i += 4;
                count++;
            }
            else {
                // todo: check for other escape sequences
                
                [chars addCharactersInRange:NSMakeRange(c, 1)];
                lastChar = c;
                count++;
            }
            
            escape = NO;
        }
        else if (enclosed && c == '-' && i > 0 && i < range.length - 1) {
            // process character range
            
            unichar rangeStart = [pattern characterAtIndex:(range.location + i - 1)];
            unichar rangeEnd = [pattern characterAtIndex:(range.location + i + 1)];
            
            if (rangeEnd < rangeStart)
                [self raiseParserError:@"Invalid character range" atPos:(range.location + i - 1)];
            
            NSCharacterSet *alphanum = [NSCharacterSet alphanumericCharacterSet];
            if (![alphanum characterIsMember:rangeStart] || ![alphanum characterIsMember:rangeEnd])
                [self raiseParserError:@"Invalid character range" atPos:(range.location + i - 1)];
            
            // iOS5 has a bug: things go ugly if range intersects with existing one, so exclude it first
            [chars removeCharactersInRange:NSMakeRange(rangeStart, rangeEnd - rangeStart + 1)];
            [chars addCharactersInRange:NSMakeRange(rangeStart, rangeEnd - rangeStart + 1)];
            i++;
            count += 2;
        }
        else {
            // process simple char
            
            [chars addCharactersInRange:NSMakeRange(c, 1)];
            lastChar = c;
            count++;
        }
    }
    
    if (!negation && count == 1) {
        SSReLiteral *l = [[SSReLiteral alloc] init];
        l.character = lastChar;
        l.sourceRange = range;
        l.ignoreCase = _ignoreCase;
        return l;
    } else {
        SSReCharacterSet *s = [[SSReCharacterSet alloc] init];
        s.negation = negation;
        s.chars = chars;
        s.sourceRange = range;
        s.ignoreCase = _ignoreCase;
        return s;
    }
}

- (SSReGroup*)groupFromNodes:(NSArray*)nodes enclosed:(BOOL)enclosed
{
    if (nodes.count == 1) {
        SSReGroup *t = [nodes objectAtIndex:0];
        if ([t isKindOfClass:[SSReGroup class]]) {
            t.capturing |= enclosed;
            return t;
        }
    }
    
    SSReGroup *g = [[SSReGroup alloc] init];
    g.children = [nodes copy];
    g.capturing = enclosed;
    
    // setup links
    SSReNode *prev = [g.children objectAtIndex:0];
    prev.parent = g;
    
    for (NSUInteger i = 1; i < g.children.count; i++) {
        SSReNode *curr = [g.children objectAtIndex:i];
        curr.parent = g;
        prev.nextSibling = curr;
        prev = curr;
    }
    
    return g;
}

- (SSReGroup*)parseSubpattern:(NSString*)pattern inRange:(NSRange)range enclosed:(BOOL)enclosed
{
    NSMutableArray *nodes = [[NSMutableArray alloc] initWithCapacity:range.length];
    
    NSMutableArray *alternations = nil;
    NSUInteger startPos = 0, endPos = range.length;
    
    BOOL escape = NO;
    SSReNode *lastnode = nil;
    
    for (NSUInteger i = 0; i < range.length; i++) {
        if (_finished)
            [self raiseParserError:@"Found pattern end in the middle of string" atPos:(range.location + i)];
        
        unichar c = [pattern characterAtIndex:(range.location + i)];
        
        if (enclosed && i == 0 && c == '?') {
            // group modifiers are present
            
            if (range.length < 3)
                [self raiseParserError:@"Invalid group found in pattern" atPos:(range.location + i)];
            
            NSCharacterSet *alphanum = [NSCharacterSet alphanumericCharacterSet];
            
            unichar d = [pattern characterAtIndex:(range.location + i + 1)];
            if (d == '<') {
                // tagged group (?<style1>…)
                for (NSUInteger j = i + 2; j < range.length; j++) {
                    unichar d = [pattern characterAtIndex:(range.location + j)];
                    
                    if (d == '<') {
                        [self raiseParserError:@"Invalid group tag found in pattern" atPos:(range.location + j)];
                    } else if (d == '>') {
                        if (j == i + 2)
                            [self raiseParserError:@"Empty group tag found in pattern" atPos:(range.location + j)];
                        i = j;
                        break;
                    } else if (![alphanum characterIsMember:d]) {
                        [self raiseParserError:@"Group tag contains invalid chars" atPos:(range.location + j)];
                    }
                }
            }
            else if (d == '\'') {
                // tagged group (?'style2'…)
                for (NSUInteger j = i + 2; j < range.length; j++) {
                    unichar d = [pattern characterAtIndex:(range.location + j)];
                    
                    if (d == '\'') {
                        if (j == i + 2)
                            [self raiseParserError:@"Empty group tag found in pattern" atPos:(range.location + j)];
                        i = j;
                        break;
                    } else if (![alphanum characterIsMember:d]) {
                        [self raiseParserError:@"Group tag contains invalid chars" atPos:(range.location + j)];
                    }
                }
            }
            else if (d == ':') {
                // non-capturing group
                enclosed = FALSE;
                i++;
            }
            else {
                [self raiseParserError:@"Unknown group modifier" atPos:(range.location + i + 1)];
            }
            
            continue;
        }
        
        if (c == '\\' && !escape) {
            escape = YES;
            continue;
        }
        
        if (escape) {
            if (![self isValidEscapedChar:c inCharset:NO] || i == 0)
                [self raiseParserError:@"Invalid escape sequence" atPos:(range.location + i)];
            
            lastnode = [self parseCharset:pattern inRange:NSMakeRange(range.location + i - 1, 2) enclosed:NO];
            [nodes addObject:lastnode];
            
            escape = NO;
        }
        else if (c == '(') {
            NSInteger brackets = 1;
            BOOL escape2 = NO;
            
            for (NSUInteger j = i + 1; j < range.length; j++) {
                unichar d = [pattern characterAtIndex:(range.location + j)];
                
                if (escape2) {
                    escape2 = NO;
                } else if (d == '\\') {
                    escape2 = YES;
                } else if (d == '(') {
                    brackets++;
                } else if (d == ')') {
                    brackets--;
                    
                    if (brackets == 0) {
                        lastnode = [self parseSubpattern:pattern inRange:NSMakeRange(range.location + i + 1, j - i - 1) enclosed:YES];
                        [nodes addObject:lastnode];
                            
                        i = j;
                        break;
                    }
                }
            }
            
            if (brackets != 0)
                [self raiseParserError:@"Unclosed group bracket" atPos:(range.location + i)];
        }
        else if (c == ')') {
            [self raiseParserError:@"Unopened group bracket" atPos:(range.location + i)];
        }
        else if (c == '[') {
            BOOL escape2 = NO;
            BOOL valid = NO;
            
            for (NSUInteger j = i + 1; j < range.length; j++) {
                unichar d = [pattern characterAtIndex:(range.location + j)];
                
                if (escape2) {
                    escape2 = NO;
                } else if (d == '\\') {
                    escape2 = YES;
                } else if (d == '[' || d == '(' || d == ')') {
                    // invalid character
                    break;
                } else if (d == ']') {
                    lastnode = [self parseCharset:pattern inRange:NSMakeRange(range.location + i + 1, j - i - 1) enclosed:YES];
                    [nodes addObject:lastnode];
                        
                    i = j;
                    valid = YES;
                    break;
                }
            }
            
            if (!valid)
                [self raiseParserError:@"Unclosed character set bracket" atPos:(range.location + i)];
        }
        else if (c == ']') {
            [self raiseParserError:@"Unopened character set bracket" atPos:(range.location + i)];
        }
        else if (c == '{') {
            if (lastnode == nil || [lastnode isKindOfClass:[SSReQuantifier class]])
                [self raiseParserError:@"Invalid quantifier usage" atPos:(range.location + i)];
            
            BOOL valid = NO;
            
            for (NSUInteger j = i + 1; j < range.length; j++) {
                unichar d = [pattern characterAtIndex:(range.location + j)];
                
                if (d == '}') {
                    NSString *from, *to;
                    
                    NSTextCheckingResult *m = [_exactQuantifierRegex firstMatchInString:pattern options:0 range:NSMakeRange(range.location + i, j - i + 1)];
                    if (m != nil) {
                        from = [pattern substringWithRange:[m rangeAtIndex:1]];
                        to = from;
                    } else {
                        m = [_rangeQuantifierRegex firstMatchInString:pattern options:0 range:NSMakeRange(range.location + i, j - i + 1)];
                        if (m == nil)
                            [self raiseParserError:@"Invalid quantifier format" atPos:(range.location + i)];
                    
                        from = [pattern substringWithRange:[m rangeAtIndex:1]];
                        to = [pattern substringWithRange:[m rangeAtIndex:2]];
                    }
                    
                    SSReQuantifier *qtf = [[SSReQuantifier alloc] init];
                    
                    if (from == nil || [from isEqualToString:@""])
                        qtf.countFrom = 0;
                    else
                        qtf.countFrom = [from integerValue];
                    
                    if (to == nil || [to isEqualToString:@""])
                        qtf.countTo = NSUIntegerMax;
                    else
                        qtf.countTo = [to integerValue];
                    
                    if (qtf.countFrom > qtf.countTo)
                        [self raiseParserError:@"Invalid quantifier range" atPos:(range.location + i)];
                    
                    [nodes removeLastObject];
                    qtf.child = lastnode;
                    lastnode.parent = qtf;
                    lastnode = qtf;
                    [nodes addObject:lastnode];
                    
                    i = j;
                    valid = YES;
                    break;
                }
            }
            
            if (!valid)
                [self raiseParserError:@"Unclosed quantifier bracket" atPos:(range.location + i)];
        }
        else if (c == '}') {
            [self raiseParserError:@"Unopened qualifier bracket" atPos:(range.location + i)];
        }
        else if (c == '*') {
            if (lastnode == nil || [lastnode isKindOfClass:[SSReQuantifier class]])
                [self raiseParserError:@"Invalid quantifier usage" atPos:(range.location + i)];
            
            [nodes removeLastObject];
            SSReQuantifier *qtf = [[SSReQuantifier alloc] initWithFrom:0 to:NSUIntegerMax];
            qtf.child = lastnode;
            lastnode.parent = qtf;
            lastnode = qtf;
            [nodes addObject:lastnode];
        }
        else if (c == '+') {
            if (lastnode == nil || [lastnode isKindOfClass:[SSReQuantifier class]])
                [self raiseParserError:@"Invalid quantifier usage" atPos:(range.location + i)];
            
            [nodes removeLastObject];
            SSReQuantifier *qtf = [[SSReQuantifier alloc] initWithFrom:1 to:NSUIntegerMax];
            qtf.child = lastnode;
            lastnode.parent = qtf;
            lastnode = qtf;
            [nodes addObject:lastnode];
        }
        else if (c == '?') {
            if (lastnode == nil)
                [self raiseParserError:@"Invalid quantifier usage" atPos:(range.location + i)];
            
            if ([lastnode isKindOfClass:[SSReQuantifier class]]) {
                // greediness modifier
                [(SSReQuantifier*)lastnode setGreedy:NO];
            } else {
                [nodes removeLastObject];
                SSReQuantifier *qtf = [[SSReQuantifier alloc] initWithFrom:0 to:1];
                qtf.child = lastnode;
                lastnode.parent = qtf;
                lastnode = qtf;
                [nodes addObject:lastnode];
            }
            
            lastnode = nil;
        }
        else if (c == '.') {
            // any character
            lastnode = [[SSReAnyCharacter alloc] init];
            [nodes addObject:lastnode];
        }
        else if (c == '|') {
            // alternation
            if (alternations == nil)
                alternations = [[NSMutableArray alloc] initWithCapacity:2];
            
            SSReGroup *g = [self groupFromNodes:nodes enclosed:enclosed];
            g.sourceRange = NSMakeRange(range.location + startPos, i - startPos);
            startPos = i + 1;
            
            [alternations addObject:g];
            [nodes removeAllObjects];
            lastnode = nil;
        }
        else if (c == '$') {
            if (alternations != nil && enclosed)
                [self raiseParserError:@"End of string shouldn't be inside alternation" atPos:(range.location + i)];
            
            if (range.location + i + 1 < pattern.length)
                [self raiseParserError:@"Unexpected end of string" atPos:(range.location + i + 1)];
            
            lastnode = [[SSReEndOfString alloc] init];
            [nodes addObject:lastnode];
            
            endPos = i + 1;
            _finished = YES;
            break;
        }
        else {
            lastnode = [self parseCharset:pattern inRange:NSMakeRange(range.location + i, 1) enclosed:NO];
            [nodes addObject:lastnode];
        }
    }
    
    if (escape)
        [self raiseParserError:@"Invalid group ending" atPos:(range.location + range.length)];

    NSUInteger endPosForGroup = endPos;
    if (alternations != nil && _finished && !enclosed)
    {
        // root-level alternation not included in parenthesis:
        // ^aaa|bbb$
        // need to strip end-of-string node from last group
        [nodes removeLastObject];
        // and decrement last alternation length by 1
        endPosForGroup--;
    }
    
    SSReGroup *g = [self groupFromNodes:nodes enclosed:enclosed];
    g.sourceRange = NSMakeRange(range.location + startPos, endPosForGroup - startPos);
    g.capturing = enclosed;
    
    if (alternations != nil) {
        // build alternation and enclose it into group
        [alternations addObject:g];
        
        SSReAlternation *a = [[SSReAlternation alloc] init];
        a.children = alternations;
        a.sourceRange = NSMakeRange(range.location, endPos);
        
        // setup links
        SSReNode *prev = [alternations objectAtIndex:0];
        prev.parent = a;
        
        for (NSUInteger i = 1; i < alternations.count; i++) {
            SSReNode *curr = [alternations objectAtIndex:i];
            curr.parent = a;
            prev.nextSibling = curr;
            prev = curr;
        }
        
        g = [[SSReGroup alloc] init];
        g.children = [NSArray arrayWithObject:a];
        g.capturing = enclosed;
        g.sourceRange = a.sourceRange;
        
        a.parent = g;
        
        if (_finished && !enclosed)
        {
            a.nextSibling = lastnode;
            lastnode.parent = g;
            g.children = [NSArray arrayWithObjects:a, lastnode, nil];
        }
    }
    
    return g;
}

- (NSString*)reformatString:(NSString *)input
{
    // empty strings are ok
    if (input == nil || [input isEqualToString:@""]) return input;
    
    NSMutableString *tInput = [input mutableCopy];
    
    @autoreleasepool {
        SSState *initialState = [[SSState alloc] init];
        SSState *finalState = [self processNode:_node fromState:initialState length:input.length];
        
        SSState *x = [self nextState:initialState finalState:finalState input:tInput position:0];
        
        return x.isFinal ? tInput : nil;
    }
}

- (SSState*)processNode:(SSReNode*)node fromState:(SSState*)state length:(NSUInteger)length
{
    if ([node isKindOfClass:[SSReEndOfString class]])
    {
        SSState *finalState = [[SSState alloc] init];
        finalState.isFinal = YES;
        
        SSTransition *tran = [[SSTransition alloc] init];
        tran.node = (SSReCharacterBase*)node;
        tran.nextState = finalState;
        [state.transitions addObject:tran];
        
        return finalState;
    }
    else if ([node isKindOfClass:[SSReCharacterBase class]])
    {
        SSState *finalState = [[SSState alloc] init];
        
        SSTransition *tran = [[SSTransition alloc] init];
        tran.node = (SSReCharacterBase*)node;
        tran.nextState = finalState;
        [state.transitions addObject:tran];
        
        return finalState;
    }
    else if ([node isKindOfClass:[SSReQuantifier class]])
    {
        SSReQuantifier *qtf = (SSReQuantifier*)node;
        
        SSState *curState = state;
        for (NSUInteger i = 0; i < qtf.countFrom; i++) {
            curState = [self processNode:qtf.child fromState:curState length:length];
        }
        
        if (qtf.countTo == qtf.countFrom)
        {
            // strict quantifier
            return curState;
        }
        
        SSState *finalState = [[SSState alloc] init];
        
        for (NSUInteger i = qtf.countFrom; i < MIN(qtf.countTo, length); i++) {
            SSState *nextState = [self processNode:qtf.child fromState:curState length:length];
            
            SSTransition *tran = [[SSTransition alloc] init];
            tran.node = nil;
            tran.nextState = finalState;
            
            if (qtf.greedy)
                [curState.transitions addObject:tran];
            else
                [curState.transitions insertObject:tran atIndex:0];
            
            curState = nextState;
        }
        
        SSTransition *tran = [[SSTransition alloc] init];
        tran.node = nil;
        tran.nextState = finalState;
        [curState.transitions addObject:tran];
        
        return finalState;
    }
    else if ([node isKindOfClass:[SSReGroup class]])
    {
        SSReGroup *grp = (SSReGroup*)node;
        
        SSState *curState = state;
        for (NSUInteger i = 0; i < grp.children.count; i++) {
            curState = [self processNode:[grp.children objectAtIndex:i] fromState:curState length:length];
        }
        
        if (!grp.capturing && grp.children.count == 1 && [[grp.children objectAtIndex:0] isKindOfClass:[SSReLiteral class]])
        {
            SSTransition *tran = [[SSTransition alloc] init];
            tran.node = nil;
            tran.bypassNode = (SSReLiteral*)[grp.children objectAtIndex:0];
            tran.nextState = curState;
            [state.transitions addObject:tran];
        }
        
        return curState;
    }
    else if ([node isKindOfClass:[SSReAlternation class]])
    {
        SSReAlternation *alt = (SSReAlternation*)node;
        
        SSState *finalState = [[SSState alloc] init];
        
        for (NSUInteger i = 0; i < alt.children.count; i++) {
            SSState *curState = [self processNode:[alt.children objectAtIndex:i] fromState:state length:length];
            
            SSTransition *tran = [[SSTransition alloc] init];
            tran.node = nil;
            tran.nextState = finalState;
            [curState.transitions addObject:tran];
        }
        
        return finalState;
    }
    else
    {
        NSAssert(YES, @"Unsupported node type");
        return nil;
    }
}

- (SSState*)nextState:(SSState*)state finalState:(SSState*)final input:(NSMutableString*)input position:(NSUInteger)pos
{
    if (state.isFinal) return state;
    
    if (pos > input.length) return final;
    
    for (SSTransition *tran in state.transitions) {
        
        NSUInteger nextPos = pos;

        if (tran.node != nil) {
            unichar c = (pos < input.length) ? [input characterAtIndex:pos] : 0;
            if (![tran.node matchesCharacter:c])
            {
                if (c == 0) return final;
#ifdef DEBUG
                //NSLog(@"Fail: %@ @ %u", [tran.node displayString:_pattern], pos);
#endif
                continue;
            }
            else
            {
#ifdef DEBUG
                //NSLog(@"Pass: %@ @ %u", [tran.node displayString:_pattern], pos);
#endif
            }
            nextPos += 1;
        }
        
        SSState *s = [self nextState:tran.nextState finalState:final input:input position:nextPos];
        if (s.isFinal)
        {
            if (tran.bypassNode != nil)
                [input insertString:[NSString stringWithFormat:@"%c", tran.bypassNode.character] atIndex:nextPos];
            
            return s;
        }
    }
    
    return nil;
}

@end
