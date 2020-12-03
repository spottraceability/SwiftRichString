//
//  SwiftRichString
//  https://github.com/malcommac/SwiftRichString
//  Copyright (c) 2020 Daniele Margutti (hello@danielemargutti.com).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation
#if os(OSX)
import AppKit
#else
import UIKit
#endif

/// StyleRegEx allows you to define a style which is applied when one or more regular expressions
/// matches are found in source string or attributed string.
public struct StyleRegEx: StyleProtocol {
	
	//MARK: - Public Properties
	
	/// Regular expression
	public private(set) var regex: NSRegularExpression
	
	/// Base style. If set it will be applied in set before any match.
	public private(set) var baseStyle: StyleProtocol?
	
	/// Applied style
	private var style: StyleProtocol
	
	/// Style attributes
	public var attributes: [NSAttributedString.Key : Any] {
        style.attributes
	}
	
    public var textTransforms: [TextTransform]?
    
	/// Font attributes
	public var fontStyle: FontStyle? {
        style.fontStyle
	}
	
	//MARK: - Initialixation
	
	/// Initialize a new regular expression style matcher.
	///
	/// - Parameters:
	///   - base: base style. it will be applied (in set or add) to the entire string before any other operation.
	///   - pattern: pattern of regular expression.
	///   - options: matching options of the regular expression; if not specified `caseInsensitive` is used.
	///   - handler: configuration handler for style.
	public init?(base: StyleProtocol? = nil,
				 pattern: String, options: NSRegularExpression.Options = .caseInsensitive,
				 handler: @escaping Style.StyleInitHandler) {
		do {
			self.regex = try NSRegularExpression(pattern: pattern, options: options)
			self.baseStyle = base
			self.style = Style(handler)
		} catch {
			return nil
		}
	}
	
}