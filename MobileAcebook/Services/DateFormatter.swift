//
//  DateFormatter.swift
//  MobileAcebook
//
//  Created by Amy McCann on 21/02/2024.
//

import Foundation

func convertDateFormat(inputDate: String) -> String {
    let oldFormat = DateFormatter()
    oldFormat.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    guard let oldDate = oldFormat.date(from: inputDate) else { return "" }
    
    let newDateFormat = DateFormatter()
    newDateFormat.dateFormat = "dd MMM yyy h:mm a"
    return newDateFormat.string(from: oldDate)
}
