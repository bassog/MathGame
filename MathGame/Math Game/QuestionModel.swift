//
//  QuestionModel.swift
//  Math Game
//
//  Created by Gregory Basso on 27/05/2020.
//  Copyright © 2020 Andrew basso. All rights reserved.
//

import Foundation


class QuestionGenerator {

    func generateQuestion() -> Questions {
        
        //declare our variables
        let ques = Questions()
        var answer = [Int]()
        var wrongAnswer = [Int]()
                
        // Generator random for the Question
        let randomNumber1 = Int.random(in: 3...15)
        let randomNumber2 = Int.random(in: 3...15)
               
        //create our Question and correct answer
        ques.question = "\(randomNumber1) X \(randomNumber2)"
        
        //Log question
        print("The question is: \(ques.question)")
        
        ques.correctanswer = randomNumber1 * randomNumber2
        
        //Log correct answer
        print("The answer is: \(ques.correctanswer)")
        
        //Add correct answer to answer array
        answer.append(ques.correctanswer)


        //create the wrong answers and add to wrong answer array
        wrongAnswer.append(randomNumber1 * (randomNumber2 + 1))
        wrongAnswer.append(randomNumber1 * randomNumber2 + 1)
        wrongAnswer.append(randomNumber1 * randomNumber2 - 1)
        wrongAnswer.append(randomNumber1 * (randomNumber2 - 1))
        wrongAnswer.append(randomNumber1 * randomNumber2 + 2)
        wrongAnswer.append(randomNumber1 * randomNumber2 - 2)
        
      
        //shuffle wrong answer array to randomize wrong answers
        wrongAnswer.shuffle()
        
        //add 3 wrong answers to answer array
        answer.append(wrongAnswer[0])
        answer.append(wrongAnswer[1])
        answer.append(wrongAnswer[3])
        
        //shuffle answer array to randomize answers
        answer.shuffle()
        
        //Log all answers
        print("All answers: \(answer)")

        //place the correct answer in one of the 4 answers
        ques.answer1 = answer[0]
        ques.answer2 = answer[1]
        ques.answer3 = answer[2]
        ques.answer4 = answer[3]
        
       //return question and answer
        return ques
      
    }


}
