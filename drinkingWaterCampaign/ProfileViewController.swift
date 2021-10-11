//
//  ProfileViewController.swift
//  drinkingWaterCampaign
//
//  Created by Kanghos on 2021/10/11.
//

import UIKit
import TextFieldEffects
class ProfileViewController: UIViewController {
    
    
    @IBOutlet var nickNameTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var weightTextField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //초기화
        nickNameTextField.text = UserDefaults.standard.string(forKey: "nickName")
        heightTextField.text = "\(UserDefaults.standard.double(forKey: "height"))"
        weightTextField.text = "\(UserDefaults.standard.integer(forKey: "weight"))"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        print("!")
    }
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        //유저디폴트값에 저장
        let nickName = nickNameTextField.text ?? ""
        
        if (nickName).isEmpty{
            //Altert 띄우기
            showAlert("닉네임을 입력해주세요")
            return
        }else {
            
            UserDefaults.standard.set(nickName, forKey: "nickName")
        }
        
        let height = heightTextField.text ?? "0.0"
        
        if (height) == "0.0" || height.isEmpty{
            //Altert 띄우기
            showAlert("키를 입력해주세요")
            
            return
        }else {
            
            UserDefaults.standard.set(Int(height), forKey: "height")
        }
        
        let weight = weightTextField.text ?? "0"
        
        if weight == "0" || weight.isEmpty {
            showAlert("몸무게를 입력해주세요")
            return
        }else {
            UserDefaults.standard.set(Int(weight), forKey: "weight")
        }
        showAlert("저장되었습니다.", "알림")
    }
    
    func showAlert(_ contextMsg:String, _ title:String = "에러"){
        //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: title, message: contextMsg, preferredStyle: .alert)
        
        //2. UIalertAction 생성 : 버튼들..
        
        
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        
        //3. 1 + 2
        //.cancel is located bottom
        
        alert.addAction(cancel)
        
        //UIColorPicker ViewController
        //let colorPicker = UIColorPickerViewController()
        
        //4. Present Modal 형식
        
        present(alert, animated: true, completion: nil)
    }
}
