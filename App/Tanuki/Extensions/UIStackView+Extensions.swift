//
//  UIStackView+Extensions.swift
//  Tanuki
//
//  Created by Constantin on 04.07.2023.
//

import UIKit

extension UIStackView {
	func addArrangedSubviews(_ views: [UIView]) {
		views.forEach { addArrangedSubview($0) }
	}
}
