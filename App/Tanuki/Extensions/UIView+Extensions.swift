//
//  UIView+Extensions.swift
//  Tanuki
//
//  Created by Constantin on 08.07.2023.
//

import UIKit

extension UIView {
	func addSubviews(_ views: [UIView]) {
		views.forEach { addSubview($0) }
	}
}
