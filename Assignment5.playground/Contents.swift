//: Playground - noun: a place where people can play

import Foundation


let conditionals = [4, 100, 400]

func isLeap(year: Int) -> Bool{
    return conditionals.reduce(false) { return $0 != ((year % $1) == 0) }
}



let months = [0,31,59,90,120,151,181,212,243,273,304,334]

func julianDate(year: Int, month: Int, day: Int) -> Int{
    let yearDays = (1900..<year).reduce(0) { return (isLeap($1) ? 366 : 365) + $0 }
    let monthDays = isLeap(year) && month > 2 ? months[month-1] + 1 : months[month-1]
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


/* Project Bonus Proposal
   (dont know if this is where I should put this, I'll also email Van)
I want to do something similar to mutation. I was thinking of making a rule change so that something happens when the game reaches a stable state to keep the game going. I was thinking either randomizing the board, or bringing to life all the neighbors of living cells when the board stabilizes. I like the idea of the latter, but I would have to experiment to make sure all the cells dont just die out from overpopulation.
 There seems to be two kinds of stabilization, one where grid = step(grid) (this includes when the grid is completely dead), and one where grid = step(step(grid)) (where the grid alternates between two states). I would have to handle both these cases, and change the board so the game keeps going. With this rule change, the game would (hopefully) be endless.
 */