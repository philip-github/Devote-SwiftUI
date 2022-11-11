//
//  Constant.swift
//  Devote
//
//  Created by Philip Al-Twal on 10/20/22.
//

import SwiftUI


//MARK: - DATE FORMATTER
public let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//MARK: - UI
var backgroundGradient: LinearGradient {
    return LinearGradient(colors: [Color.pink, Color.blue],
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing)
}


//MARK: - UX
let feedback = UINotificationFeedbackGenerator()
