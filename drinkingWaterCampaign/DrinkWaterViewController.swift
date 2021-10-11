//
//  DrinkWaterViewController.swift
//  drinkingWaterCampaign
//
//  Created by Kanghos on 2021/10/11.
//

import UIKit

enum UserState:Int {
    case normal=1, overflow=2, lack=0
    
    func showStatus() -> String {
        switch self {
        case .normal:
            return "잘하고 있어요"
        case .overflow:
            return "그만!"
        case .lack:
            return "더 마셔야해요"
        }
            
    }
}
class DrinkWaterViewController: UIViewController {

    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var stateLabel: UILabel!
    @IBOutlet var waterAmountLabel: UILabel!
    @IBOutlet var goalAmountLabel: UILabel!
    @IBOutlet var stateImage: UIImageView!
    @IBOutlet var averageAmountLabel: UILabel!
    
    var userState:UserState = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(named: "contentBackground")
        
        //뷰 리프레쉬
        refreshViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        refreshViews()
    }
    @IBAction func inputWaterReturnPressed(_ sender: UITextField) {
        print("return Key Pressed")
    }
    @IBAction func drinkButtonClicked(_ sender: UIButton) {
        //guard let waterInput = waterTextField.text else { return }
        
        if let waterInput = waterTextField.text {
            let waterAmount = UserDefaults.standard.integer(forKey: "waterAmount")
            var waterInputValue = 0
            if waterInput.isEmpty == false {
                waterInputValue = Int(waterInput)!
            }
            let totalAmount = waterAmount + waterInputValue
            
            UserDefaults.standard.set(totalAmount, forKey: "waterAmount")
            waterAmountLabel.text = "\(UserDefaults.standard.integer(forKey: "waterAmount"))ml"
            waterTextField.text = nil
            
            refreshViews()
        }
        
    }
    
    func refreshViews(){
        
        let nickName = UserDefaults.standard.string(forKey: "nickName") ?? "기본 사용자"
        
        //총 섭취량
        let waterAmount = UserDefaults.standard.integer(forKey: "waterAmount")
        waterAmountLabel.text = "\(waterAmount)ml"
        
        //목표 퍼센트와 권장량
        let goalAmount = (Double(UserDefaults.standard.integer(forKey: "weight")) + UserDefaults.standard.double(forKey: "height")) / 100.0
        let goalPercent = Int(Double(waterAmount) / (goalAmount * 1000.0) * 100)
        
        goalAmountLabel.text = "목표의 \(goalPercent)%"
        averageAmountLabel.text =  "\(nickName)님의 하루 권장럅은 \(goalAmount)L 입니다."
        
        let state = goalPercent/10
        
        //이미지 초기화
        stateImage.image = UIImage(named: "1-\(state).png")
        
        if state < 5 {
            userState = .lack
        }else if state < 10 {
            userState = .normal
        }else {
            userState = .overflow
        }
        
        //상태 변화
        stateLabel.text = userState.showStatus()
        
        if userState.rawValue == 1 {
            stateLabel.textColor = .white
        }else {
            stateLabel.textColor = .red
        }
            
        //print(waterAmount + ", " + goalAmount + ", " + goalPercent + state)
        //이미지 초기화
        
        
        
    }
    
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
        
        UserDefaults.standard.set(0, forKey: "waterAmount")
        refreshViews()
    }
    
    

}
