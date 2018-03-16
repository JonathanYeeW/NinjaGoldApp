//
//  EventScreenDelegate.swift
//  GameBoy Pocket
//
//  Created by Jonathan Yee on 3/15/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import Foundation

protocol EventScreenDelegate: class {
    func eventOccured(by controller: EventScreenViewController, adjective: String)
}
