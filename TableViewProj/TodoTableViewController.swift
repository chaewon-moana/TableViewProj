//
//  TodoTableViewController.swift
//  TableViewProj
//
//  Created by cho on 1/7/24.
//

import UIKit

struct Todo {
    var name: String
    var starkMark: Bool
    var todoCheck: Bool
}

class TodoTableViewController: UITableViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mainView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var todoList: [Todo] = [Todo(name: "운동하기", starkMark: false, todoCheck: false),
                            Todo(name: "설 기차예매", starkMark: true, todoCheck: false),
                            Todo(name: "test1", starkMark: false, todoCheck: false),
                            Todo(name: "test2", starkMark: false, todoCheck: false)
    ]
    
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
 
        todoList.sort(by: {$0.starkMark && !$1.starkMark})
        
        cell.mainCellView.backgroundColor = .systemGray6
        cell.mainCellView.layer.cornerRadius = 8
        
        cell.checkBoxButton.setTitle("", for: .normal)
        cell.checkBoxButton.tintColor = .black
        
        cell.starMarkButton.setTitle("", for: .normal)
        cell.starMarkButton.tintColor = .black
        
        cell.selectionStyle = .none
        
        let value = todoList[indexPath.row]
        
        cell.mainLabel.text = value.name
        cell.mainLabel.textColor = value.todoCheck ? .gray : .black
        cell.checkBoxButton.setImage(UIImage(systemName: value.todoCheck ? "checkmark.square.fill" : "checkmark.square"), for: .normal)
        cell.checkBoxButton.tag = indexPath.row
        
        cell.starMarkButton.setImage(UIImage(systemName: value.starkMark ? "star.fill" : "star"), for: .normal)
        cell.starMarkButton.tag = indexPath.row
        
        print(indexPath.row)
        return cell
    }
    

    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = searchTextField.text else {
            print("textField 에러 발생")
            return
        }
        if text != "" {
            todoList.append(Todo(name: text, starkMark: false, todoCheck: false))
        }
        tableView.reloadData()
        searchTextField.text = nil
    }
        
    @IBAction func checkBoxTapped(_ sender: UIButton) {
        todoList[sender.tag].todoCheck.toggle()
        tableView.reloadData()
    }
    
    @IBAction func starMarkTapped(_ sender: UIButton) {
        todoList[sender.tag].starkMark.toggle()
        tableView.reloadData()
    }
    
    @IBAction func keyboardReturnTapped(_ sender: UITextField) {
        guard let text = sender.text else {
            print("textField 에러 발생")
            return
        }
        if text != "" {
            todoList.append(Todo(name: text, starkMark: false, todoCheck: false))
        }
        tableView.reloadData()
        sender.text = ""
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//   
//        var cnt = 0
//        
//        for i in 0...todoList.count - 1 {
//            if todoList[i].starkMark {
//                cnt += 1
//            }
//        }
//        
//        if section == 0 {
//            return cnt
//        } else {
//            return todoList.count - cnt
//        }
        return todoList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //수정관련 코드
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todoList.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    //헤더관련 코드
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "우선순위"
//        } else {
//            return "Todo"
//        }
//    }
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
}
