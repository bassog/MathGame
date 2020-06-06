//
//  ViewController.swift
//  Math Game
//
//  Created by Gregory Basso on 26/05/2020.
//  Copyright © 2020 Andrew basso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var highScore: UILabel!
    
    
    let model = QuestionGenerator()
    
    var ques: Questions?
    var timer = Timer()
    var timeLimit:Float = 1
    var time:Float = 0
    var currentProgress:Float = 0
    var correctTimeSave: Float = 0.1
    var playerScore = 0
    var hScore = UserDefaults().integer(forKey: "highscore")
    
    
    var soundPlayer = SoundManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Get the first question
        ques = model.generateQuestion()
        
        //Assing the value to the view
        assignValues(values: ques!)
        
        //Set the high score stored in user defaults
        highScore.text = "High Score: \(hScore)"
        
        //Start game
        startGame()
        
        
    }
    
    //MARK: - Timer method & Progress Bar Update
    @objc func timerFired() {
        
        //update time
        time += 0.01
        //Stop if the time equals time limit
        if time >= timeLimit {
            endGame()
        }
        else {
            currentProgress = time
        }
        
        //update the progress bar
        progressView.progress = currentProgress
        
        
        
    }
    
    func updateTime () {
        
        time -= correctTimeSave
        
        if time < 0 {
            time = 0
        }
        
    }
    
    //MARK: - Button actions
    @IBAction func button1Touch(_ sender: Any) {
        
        //Check if it is the correct answer
        if ques!.answer1 == ques!.correctanswer {
            
            //Decrement Time
            updateTime()
            
            //Update Score
            playerScore += 1
            score.text = String(playerScore)
        }
        else  {
            
            endGame()
        }
        
        //Assing the value to the view for new question
        ques = model.generateQuestion()
        assignValues(values: ques!)
        
    }
    
    
    @IBAction func button2Touch(_ sender: Any) {
        
        //Check if it is the correct answer
        if ques!.answer2 == ques!.correctanswer {
            
            //Decrement Time
            updateTime()
            
            //Update Score
            playerScore += 1
            score.text = String(playerScore)
        }
        else  {
            
            endGame()
        }
        
        //Assing the value to the view for new question
        ques = model.generateQuestion()
        assignValues(values: ques!)
    }
    
    
    @IBAction func buttonTouch3(_ sender: Any) {
        
        
        //Check if it is the correct answer
        if ques!.answer3 == ques!.correctanswer {
            
            //Decrement Time
            updateTime()
            
            //Update Score
            playerScore += 1
            score.text = String(playerScore)
        }
        else  {
            
            endGame()
        }
        
        //Assing the value to the view for new question
        ques = model.generateQuestion()
        assignValues(values: ques!)
        
    }
    
    
    
    @IBAction func buttonTouch4(_ sender: Any) {
        
        //Check if it is the correct answer
        if ques!.answer4 == ques!.correctanswer {
            
            //Decrement Time
            updateTime()
            
            //Update Score
            playerScore += 1
            score.text = String(playerScore)
        }
        else  {
            
            endGame()
        }
        
        //Assing the value to the view for new question
        ques = model.generateQuestion()
        assignValues(values: ques!)
        
        
        
    }
    
    //MARK: - Functions
    func assignValues (values: Questions) {
        
        question.text = values.question
        button1.setTitle(String(values.answer1), for: UIControl.State.normal)
        button2.setTitle(String(values.answer2), for: UIControl.State.normal)
        button3.setTitle(String(values.answer3), for: UIControl.State.normal)
        button4.setTitle(String(values.answer4), for: UIControl.State.normal)
        
        
    }
    
    
    func startGame() {
        
        //Set progress view to 0
        progressView.progress = 0
        
        //Initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .common)
        
        //Set player score to 0
        score.text = String(playerScore)
        
        
    }
    
    func endGame() {
        
        
        //turn off time
        timer.invalidate()
        
        
        
        //If time has run out say
        if time >= timeLimit && hScore < playerScore  {
            showAlert(title: "New High Score!", message: "You scored \(playerScore) points")
            
            //Play endGame sound
            soundPlayer.playSound(effect: .endGame)
        }
        else if time >= timeLimit && hScore >= playerScore {
            showAlert(title: "Well Done!", message: "You scored \(playerScore) points")
            
            //Play endGame sound
            soundPlayer.playSound(effect: .timeUp)
            
        }
            
            //If you got the answer incorrect say
        else {
            showAlert(title: "Incorrect Answer", message: "\(ques!.question) =  \(ques!.correctanswer)")
            
            //Play endGame sound
            soundPlayer.playSound(effect: .incorrect)
        }
        
        //log high score
        if hScore == 0 || hScore < playerScore {
            hScore = playerScore
            UserDefaults.standard.set(hScore, forKey: "highscore")
        }
        
               
        highScore.text = "High Score: \(hScore)"
        
        
        //reset variables
        playerScore = 0
        time = 0
        currentProgress = 0
        
    }
    
    
    func showAlert(title: String, message:String) {
        
        //Create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        //Add a button for the user to dismiss it
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in self.startGame()})
        alert.addAction(okAction)
        
        //Show the alert
        present(alert, animated: true, completion: nil)
    }
    
}

