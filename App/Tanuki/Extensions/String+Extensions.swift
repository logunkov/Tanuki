//
//  String+Extensions.swift
//  Tanuki
//
//  Created by Constantin on 07.07.2023.
//

extension String {
	func filterN() -> String {
		String(self.filter { !"\n".contains($0) })
	}
}
