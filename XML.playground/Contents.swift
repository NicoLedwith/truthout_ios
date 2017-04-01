//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import Foundation


let d = "Tue, 28 Mar 2017 00:00:00 -0400"
let DF = DateFormatter()

DF.dateFormat = "EE, dd MMM yyyy HH:mm:ss ZZZZ"

let date = DF.date(from: d)
