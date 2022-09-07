//
//  Extension.swift
//  SignlePageTableView
//
//  Created by Hamza on 21/08/2022.
//

import Foundation

extension Date {

    func relativeDate() -> String {
        let relativeDateFormatter = DateFormatter()
        relativeDateFormatter.timeStyle = .none
        relativeDateFormatter.dateStyle = .medium
        if self < (Calendar.current.date(byAdding: .day, value: -2, to: Date()))! && self > (Calendar.current.date(byAdding: .day, value: -8, to: Date()))! {
            relativeDateFormatter.dateFormat = "EEEE"
        } else {
            relativeDateFormatter.doesRelativeDateFormatting = true
        }
        relativeDateFormatter.locale = .current
        return relativeDateFormatter.string(from: self)
    }
}
