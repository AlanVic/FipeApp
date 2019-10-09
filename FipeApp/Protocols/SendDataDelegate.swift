//
//  SendDataDelegate.swift
//  FipeApp
//
//  Created by Gabriel Palhares on 04/10/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import Foundation

protocol SendDataDelegate {
    func sendData<T>(data: T)
}
