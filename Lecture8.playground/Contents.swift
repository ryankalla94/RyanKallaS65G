//: Playground - noun: a place where people can play

import UIKit
import Foundation


let conditionals = [4, 100, 400]

func isLeap(year: Int) -> Bool{
    return conditionals.reduce(false) { return $0 != ((year % $1) == 0) }
}



let monthsNonLeapYear = [0,31,59,90,120,151,181,212,243,273,304,334]
let monthLeapYear = [0,31,60,91,121,152,182,213,244,274,305,335]

func julianDate(year: Int, month: Int, day: Int) -> Int{
    let yearDays = (1900..<year).reduce(0) { return (isLeap($1) ? 366 : 365) + $0 }
    let monthDays = isLeap(year) ? monthLeapYear[month-1] : monthsNonLeapYear[month-1]
    return yearDays + monthDays + day
}

julianDate(2016, month: 7, day: 18)



julianDate(1960, month:  9, day: 28)
julianDate(1900, month:  1, day: 1)
julianDate(1900, month: 12, day: 31)
julianDate(1901, month: 1, day: 1)
julianDate(1901, month: 1, day: 1) - julianDate(1900, month: 1, day: 1)
julianDate(2001, month: 1, day: 1) - julianDate(2000, month: 1, day: 1)
isLeap(1960)
isLeap(1900)
isLeap(2000)


