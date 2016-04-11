//
//  Public.swift
//  ZMTuan
//
//  Created by zm on 4/11/16.
//  Copyright © 2016 zm. All rights reserved.
//


import UIKit

// 获得RGB颜色
func RGBA(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
    return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func RGB(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
    return RGBA(r, g: g, b: b, a: 1.0)
}