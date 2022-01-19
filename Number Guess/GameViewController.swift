//
//  GameViewController.swift
//  Number Guess
//
//  Created by Ankush Karkar on 17/10/21.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createInfoButton(btn: infoButton)
        self.navigationItem.hidesBackButton = true
        setMinMaxValueOfSliderBasedOnLevel(selectedLevel)
        levelLable.text = selectedLevel
        setTimerCounterBasedOnLevel(selectedLevel)
        timerLabel.text="Time left: \(timerCounter)"
        enableCheckButton(false)
    }
    
    func setMinMaxValueOfSliderBasedOnLevel(_ level:String){
        slider.minimumValue=1
        switch level {
        case "Level 2":
            slider.maximumValue=50
            break
        case "Level 3":
            slider.maximumValue=100
            break
        default:
            slider.maximumValue=10
            break
        }
    }
    
    func generateRandomNumberBasedOnLevel(_ level:String){
        switch level {
        case "Level 2":
            randomNumber = Int.random(in: 1...50)
            break
        case "Level 3":
            randomNumber = Int.random(in: 1...100)
            break
        default:
            randomNumber = Int.random(in: 1...10)
            break
        }
        randomNumberLabel.text = "\(randomNumber)"
    }
    
    func setTimerCounterBasedOnLevel(_ level:String){
        switch level {
        case "Level 2":
            timerCounter=20
            break
        case "Level 3":
            timerCounter=30
            break
        default:
            timerCounter=10
            break
        }
        timerLabel.text="Time left: \(timerCounter)"
    }
    
    @IBAction func numberSlider(_ sender: UISlider) {
        selectedValue = Int(sender.value)
        print(selectedValue)
    }
    
    @IBAction func onTryPress(_ sender: UIButton) {
        enableTryButton(false)
        enableCheckButton(true)
        selectedValue=1
        timer.invalidate()
        generateRandomNumberBasedOnLevel(selectedLevel)
        setTimerCounterBasedOnLevel(selectedLevel)
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.timerFunc()
        }
        }
    }
    
    @IBAction func onCheckPress(_ sender: Any) {
       handleResult()
    }
    
    func handleResult(){
        timer.invalidate()
        attemptsCounter-=1
        attemptsLable.text="\(attemptsCounter)"
        if attemptsCounter != 0 {
            if randomNumber == selectedValue{
                score+=1
                showPopUp("win")
            } else {
                score-=1
                showPopUp("lose")
            }
        } else {
            if randomNumber == selectedValue{
                score+=1
            } else {
                score-=1
            }
            let gameOverPopup = self.storyboard?.instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
            gameOverPopup.score=score
            gameOverPopup.callOnExit={
                self.navigationController?.popViewController(animated: true)
            }
            present(gameOverPopup, animated: true)
        }
       
        totalScoreLabel.text="Total score: \(score)"
        slider.setValue(1.0, animated: true)
        enableTryButton(true)
        enableCheckButton(false)
        setTimerCounterBasedOnLevel(selectedLevel)
        timerLabel.text="Time left: \(timerCounter)"
    }
    
    @IBAction func onResetPress(_ sender: Any) {
        timer.invalidate()
        attemptsCounter=5
        attemptsLable.text="\(attemptsCounter)"
        score=0
        totalScoreLabel.text="Total score: 0"
        randomNumber=0
        randomNumberLabel.text="0"
        slider.setValue(1, animated: true)
        setTimerCounterBasedOnLevel(selectedLevel)
        timerLabel.text="Time left: \(timerCounter)"
        enableTryButton(true)
        enableCheckButton(false)
    }
    
    func enableCheckButton(_ isEnabled:Bool){
        checkButton.isEnabled=isEnabled
        if isEnabled {
            checkButton.backgroundColor=UIColor(red: 120/255, green: 0, blue: 168/255, alpha: 1)
            checkButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }else{
            checkButton.backgroundColor=UIColor.lightGray
            checkButton.setTitleColor(UIColor.darkGray, for: UIControl.State.disabled)
        }
    }
    
    func enableTryButton(_ isEnabled:Bool){
        tryButton.isEnabled=isEnabled
        if isEnabled {
            tryButton.backgroundColor=UIColor(red: 120/255, green: 0, blue: 168/255, alpha: 1)
            tryButton.setTitleColor(UIColor.white, for: UIControl.State.normal)
        }else{
            tryButton.backgroundColor=UIColor.lightGray
            tryButton.setTitleColor(UIColor.darkGray, for: UIControl.State.disabled)
        }
    }
    

    func timerFunc(){
        if timerCounter <= 0 {
           handleResult()
        }else{
            timerCounter-=1
            if timerCounter < 10{
                timerLabel.text="Time left: 0\(timerCounter)"
            }else{
                timerLabel.text="Time left: \(timerCounter)"
            }
        }
    }
    
    func showPopUp(_ result:String){
        let popUpContent = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController
        popUpContent.score=score
        popUpContent.result=result
        popUpContent.callOnExit={
            self.navigationController?.popViewController(animated: true)
        }
        present(popUpContent, animated: true)
    }
    
    var selectedLevel:String=""
    var selectedValue:Int=0
    var randomNumber:Int=0
    var timerCounter:Int=0
    var timer:Timer=Timer()
    var score:Int=0
    var attemptsCounter:Int=5
    
    @IBOutlet weak var levelLable: UILabel!
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    @IBOutlet weak var randomNumberLabel: UILabel!
    
    @IBOutlet weak var attemptsLable: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var tryButton: UIButton!
    
    @IBOutlet weak var infoButton: UIButton!
    
    func createInfoButton(btn:UIButton){
        btn.layer.borderWidth=0.8
        btn.layer.cornerRadius=0.5*btn.bounds.size.width
        btn.layer.borderColor=(UIColor(red:52/255,green: 120/255,blue: 246/255,alpha: 1)).cgColor
    }
}
