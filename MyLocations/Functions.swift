//
//  Functions.swift
//  MyLocations
//
//  Created by Tyler Moore on 11/12/20.
//

import Foundation

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}()

let dataSaveFailedNotification = Notification.Name("DataSaveFailedNotification")

func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error: \(error)")
    NotificationCenter.default.post(name: dataSaveFailedNotification, object: nil)
}
