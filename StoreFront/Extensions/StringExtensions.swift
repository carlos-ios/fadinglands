//
//  StringExtensions.swift
//  StoreFront
//
//  Created by Carlos Henderson on 2/16/23.
//

import Foundation

extension String {
    func contains(word : String) -> Bool
    {
        return self.range(of: "\\b\(word)\\b", options: .regularExpression) != nil
    }
}
