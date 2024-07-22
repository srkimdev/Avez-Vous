//
//  ProfileSettingViewModel.swift
//  Avez Vous
//
//  Created by 김성률 on 7/22/24.
//

import Foundation

final class ProfileSettingViewModel {
    
    var showRandomImage: Observable<Void?> = Observable(nil)
    var inputText: Observable<String?> = Observable("")
    
    var outputImageNumber: Observable<Int> = Observable(0)
    var outputText: Observable<String> = Observable("")
    var outputAllow: Observable<Bool> = Observable(false)
    
    init() {
        showRandomImage.bind { value in
            self.randomImage()
        }
        
        inputText.bind { value in
            self.validation()
        }
    }
    
    private func randomImage() {
        let num = Int.random(in: 0...11)
        outputImageNumber.value = num
    }
    
    private func validation() {
        
        guard let inputText = inputText.value else { return }
        
        if inputText.count < 2 || inputText.count >= 10 {
            outputText.value = validationError.isNotLength.rawValue
            outputAllow.value = false
        } else if inputText.contains("@") {
            outputText.value = validationError.isNotAt.rawValue
            outputAllow.value = false
        } else if inputText.contains("#") {
            outputText.value = validationError.isNotHash.rawValue
            outputAllow.value = false
        } else if inputText.contains("$") {
            outputText.value = validationError.isNotDollar.rawValue
            outputAllow.value = false
        } else if inputText.contains("%") {
            outputText.value = validationError.isNotPercent.rawValue
            outputAllow.value = false
        } else if isDigit(input: inputText) {
            outputText.value = validationError.isNotNumber.rawValue
            outputAllow.value = false
        } else if inputText.contains(" ") {
            outputText.value = validationError.isNotSpace.rawValue
        } else {
            outputText.value = "사용할 수 있는 닉네임이에요"
            outputAllow.value = true
        }
    }
    
    private func isDigit(input: String) -> Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        return input.rangeOfCharacter(from: decimalCharacters) != nil
    }
}
