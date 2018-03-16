//
//  GameScreenDelegate.swift
//  GameBoy Pocket
//
//  Created by Jonathan Yee on 3/15/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import Foundation

import UIKit

protocol GameScreenDelegate: class {
    func quitButtonPressed(by controller: GameScreenViewController)
}
