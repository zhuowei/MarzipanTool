//
//  NSBundle+AppKitCompat.swift
//  HelloMarzipanSwift
//
//  Created by Zhuowei Zhang on 2018-06-06.
//  Copyright © 2018 Zhuowei Zhang. All rights reserved.
//  SPDX-License-Identifier: MIT
//

import Foundation

extension Bundle {
    @objc static func currentStringsTableName() -> NSString? {
        print("Tried to get strings table name; returning nil!")
        return nil
    }
}
