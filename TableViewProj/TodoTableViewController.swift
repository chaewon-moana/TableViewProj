//
//  TodoTableViewController.swift
//  TableViewProj
//
//  Created by cho on 1/7/24.
//

import UIKit

class TodoTableViewController: UITableViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var addButton: UIButton!

    var falseList: [String] = ["운동하기", "test2", "설 연휴 기차예매", "test1"]
   // var trueList: [String] = ["설 연휴 기차예매", "test1"]
    var starMarkList: [String: Bool] = ["운동하기": false, "설 연휴 기차예매": true, "test1": true, "test2": false]
    var todoCheckList: [String: Bool] = ["운동하기": false, "설 연휴 기차예매": false, "test1": false, "test2": false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttribute()
    }
    
    func setAttribute() {
        titleLabel.text = "오늘의 할 일!"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        mainView.backgroundColor = .systemGray6
        mainView.layer.cornerRadius = 8
        
        searchTextField.placeholder = "오늘은 무엇을 해야하나요?"
        
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.backgroundColor = .systemGray5
        addButton.titleLabel?.font = .systemFont(ofSize: 14)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewController") as! TodoTableViewCell
        
        falseList = tableViewUpdate()
        
        cell.mainCellView.backgroundColor = .systemGray6
        cell.mainCellView.layer.cornerRadius = 8
        
        cell.checkBoxButton.setTitle("", for: .normal)
        cell.checkBoxButton.tintColor = .black
        
        cell.starMarkButton.setTitle("", for: .normal)
        cell.starMarkButton.tintColor = .black

        
        let value = falseList[indexPath.row]
        cell.mainLabel.text = falseList[indexPath.row]
        cell.mainLabel.textColor = todoCheckList[value]! ? .gray : .black
        cell.checkBoxButton.setImage(todoCheckList[value]! ? UIImage(systemName: "checkmark.square.fill")  : UIImage(systemName: "checkmark.square"), for: .normal)
        cell.checkBoxButton.tag = indexPath.row
        
        cell.starMarkButton.setImage(starMarkList[value]! ? UIImage(systemName: "star.fill")  : UIImage(systemName: "star"), for: .normal)
        cell.starMarkButton.tag = indexPath.row
        cell.selectionStyle = .none
        print(indexPath.row)
        return cell
    }
    
    //starMark한 항목 위로 올리는 기능 구현
    func tableViewUpdate() -> [String] {
        var tmpTrue: [String] = []
        var tmpFalse: [String] = []
        
        for i in 0...falseList.count - 1 {
            let value = falseList[i]
            if starMarkList[value] == true {
                tmpTrue.append(falseList[i])
            } else {
                tmpFalse.append(falseList[i])
            }
        }
        return tmpTrue + tmpFalse
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = searchTextField.text else {
            print("textField 에러 발생")
            return
        }
        if text != "" {
            falseList.append(text)
            todoCheckList[text] = false
            starMarkList[text] = false
        }
        tableView.reloadData()
        searchTextField.text = nil
    }
        
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        let key = falseList[sender.tag]
        let value = todoCheckList[key]!
        todoCheckList.updateValue(!value, forKey: key)
        tableView.reloadData()
    }
    
    @IBAction func starMarkTapped(_ sender: UIButton) {
            let key = falseList[sender.tag]
            let value = starMarkList[key]!
            starMarkList.updateValue(!value, forKey: key)
       
       
        tableView.reloadData()
    }
    
    
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        guard let text = sender.text else {
            print("textField 에러 발생")
            return
        }
        
        if text != "" {
            falseList.append(text)
            todoCheckList[text] = false
            starMarkList[text] = false
        }
        tableView.reloadData()
        sender.text = ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
//        if section == 0 {
//            return trueList.count
//        } else {
//            return falseList.count
//        }
//        print(count)
        return falseList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            falseList.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "즐겨찾기"
//        } else {
//            return "test"
//        }
//    }
//    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
}
