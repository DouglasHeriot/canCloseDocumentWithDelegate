//
//  NSDocument+CanCloseDocumentResponse.h
//  canCloseDocumentWithDelegate
//
//  Created by Douglas Heriot on 2/12/2015.
//  Copyright © 2015 Douglas Heriot. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSDocument (CanCloseDocumentResponse)

- (void)respondToCanClose:(BOOL)shouldClose delegate:(id)delegate selector:(SEL)shouldCloseSelector contextInfo:(void *)contextInfo;

@end
