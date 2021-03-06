//
//  Document.swift
//  canCloseDocumentWithDelegate
//
//  Created by Douglas Heriot on 2/12/2015.
//  Copyright © 2015 Douglas Heriot. All rights reserved.
//

import Cocoa

class Document: NSDocument {

	override init() {
	    super.init()
		// Add your subclass-specific initialization here.
	}

	override func windowControllerDidLoadNib(aController: NSWindowController) {
		super.windowControllerDidLoadNib(aController)
		// Add any code here that needs to be executed once the windowController has loaded the document's window.
	}

	override class func autosavesInPlace() -> Bool {
		return true
	}

	override var windowNibName: String? {
		// Returns the nib file name of the document
		// If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
		return "Document"
	}

	override func dataOfType(typeName: String) throws -> NSData {
		// Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
		// You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
		throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
	}

	override func readFromData(data: NSData, ofType typeName: String) throws {
		// Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
		// You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
		// If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
		throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
	}

	override func canCloseDocumentWithDelegate(delegate: AnyObject, shouldCloseSelector: Selector, contextInfo: UnsafeMutablePointer<Void>) {
		
		let alert = NSAlert()
		alert.messageText = "Are you sure you want to close this document?"
		alert.addButtonWithTitle("Close")
		alert.addButtonWithTitle("Cancel")
		
		alert.beginSheetModalForWindow(windowForSheet!) { (returnCode: NSModalResponse) -> Void in
			
			let shouldClose = returnCode == NSAlertFirstButtonReturn
			
			let Class: AnyClass = object_getClass(delegate)
			let method = class_getMethodImplementation(Class, shouldCloseSelector)
			
			// Method signature looks like
			// - (void)document:(NSDocument *)doc shouldClose:(BOOL)shouldClose  contextInfo:(void  *)contextInfo
			
			typealias signature = @convention(c) (AnyObject, Selector, AnyObject, Bool, UnsafeMutablePointer<Void>) -> Void
			let function = unsafeBitCast(method, signature.self)

			function(delegate, shouldCloseSelector, self, shouldClose, contextInfo)
		}
	}
}

