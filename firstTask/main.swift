//
//  main.swift
//  firstTask
//
//  Created by Alyona Hulak on 6/14/18.
//  Copyright © 2018 Alyona Hulak. All rights reserved.
//

import Foundation

print("Enter first string: ")
var firstString = readLine()
print("Enter second string: ")
var secondString = readLine()

func getCountOfLettersBetween(iterList: String, letterToFind: Character, startIndex: Int) -> Int{
    var nextLetterPos = startIndex + 1
    while (nextLetterPos < iterList.count) {
        if (letterToFind == iterList[iterList.index(iterList.startIndex, offsetBy: nextLetterPos)]) {
            break
        }
        nextLetterPos += 1
    }
    
    if nextLetterPos == iterList.count {
        return -1
    }
    
    return nextLetterPos - startIndex
}

func getOptimalVar(input: String, result: String, indexI: Int, indexR: Int) -> String {
    
    if (indexI >= input.count) {
        let lettersLeft = result.count - indexR
        var temp = ""
        if lettersLeft > 0 {
            for _ in 1...lettersLeft {
                temp += "i"
            }
        }
        return temp
    }
    if (indexR >= result.count)
    {
        let redundantLetters = input.count - indexI;
        var temp = ""
        if redundantLetters > 0 {
            for _ in 1...redundantLetters {
                temp += "d"
            }
        }
        return temp
    }
    
    if (input[input.index(input.startIndex, offsetBy: indexI)] == result[result.index(result.startIndex, offsetBy: indexR)])
    {
        return getOptimalVar(input: input, result: result, indexI: indexI + 1, indexR: indexR + 1)
    }
    
    let actualInputSize = indexR + input.count - indexI;
    if (actualInputSize < result.count)
    {
        //insert new one
        //find the same letter later, and try to insert between them new ones
        let countOfLettersToAdd = getCountOfLettersBetween(iterList: result, letterToFind: input[input.index(input.startIndex, offsetBy: indexI)], startIndex: indexR);
        let differenceBetweenSizes = result.count - actualInputSize;
        
        if (countOfLettersToAdd > 0 && differenceBetweenSizes >= countOfLettersToAdd)
        {
            var temp = ""
            if countOfLettersToAdd > 0 {
                for _ in 1...countOfLettersToAdd {
                    temp += "i"
                }
            }
            return temp + getOptimalVar(input: input, result: result, indexI: indexI + 1, indexR: indexR + countOfLettersToAdd + 1);
        }
    }
    else if (actualInputSize > result.count)
    {
        //we try to remove letters betweeen
        let countOfLettersToRemove = getCountOfLettersBetween(iterList: input, letterToFind: result[result.index(result.startIndex, offsetBy: indexR)], startIndex: indexI);
        let differenceBetweenSizes = actualInputSize - result.count;
        if (countOfLettersToRemove > 0 && differenceBetweenSizes >= countOfLettersToRemove)
        {
            //situation quite other, we shouldn`t remove more letters, than difference in actual sizes, cause this way we will pay one insert for every redundant deleting
            var temp = ""
            if countOfLettersToRemove > 0 {
                for _ in 1...countOfLettersToRemove {
                    temp += "d"
                }
            }
            return temp + getOptimalVar(input: input, result: result, indexI: indexI + countOfLettersToRemove + 1, indexR: indexR + 1);
        }
    }
    return "s" + getOptimalVar(input: input, result: result, indexI: indexI + 1, indexR: indexR + 1);
}

func getResult(input: String, result: String) -> String {
    return getOptimalVar(input: input, result: result, indexI: 0, indexR: 0)
}


print(getResult(input: firstString!, result: secondString!))
