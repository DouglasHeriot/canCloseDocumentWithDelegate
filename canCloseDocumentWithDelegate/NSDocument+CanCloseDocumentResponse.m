//
//  NSDocument+CanCloseDocumentResponse.m
//  canCloseDocumentWithDelegate
//
//  Created by Douglas Heriot on 2/12/2015.
//  Copyright © 2015 Douglas Heriot. All rights reserved.
//

#import "NSDocument+CanCloseDocumentResponse.h"

@implementation NSDocument (CanCloseDocumentResponse)

- (void)respondToCanClose:(BOOL)shouldClose delegate:(id)delegate selector:(SEL)shouldCloseSelector contextInfo:(void *)contextInfo
{
	// - (void)document:(NSDocument *)doc shouldClose:(BOOL)shouldClose  contextInfo:(void  *)contextInfo
	
	NSDocument *doc = self;
	
	NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[delegate methodSignatureForSelector:shouldCloseSelector]];
	invocation.target = delegate;
	invocation.selector = shouldCloseSelector;
	[invocation setArgument:&doc atIndex:2]; // Note index starts from 2 - 0 & 1 are self & selector
	[invocation setArgument:&shouldClose atIndex:3];
	[invocation setArgument:&contextInfo atIndex:4];
	
	[invocation invoke];
}

@end
