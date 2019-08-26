//
//  NoteButton.swift
//  MyNoteApp
//
//  Created by Hady Hammad on 8/25/19.
//  Copyright © 2019 Hady Hammad. All rights reserved.
//

import UIKit
@IBDesignable
class NoteButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
}
