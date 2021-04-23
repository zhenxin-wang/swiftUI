//
//  UserData.swift
//  ToDoList
//
//  Created by DMS on 2021/4/20.
//

import Foundation
import UserNotifications
//数据加解密
var encoder = JSONEncoder()
var decoder = JSONDecoder()
//发送通知
let notificationCentent = UNMutableNotificationContent()

class ToDo: ObservableObject{
    @Published var ToDoList: [SingleToDu]
    var count: Int = 0
    init() {
        self.ToDoList = []
    }
    
    init(data: [SingleToDu]) {
        self.ToDoList = []
        for item in data {
            self.ToDoList.append(SingleToDu(id: self.count, title: item.title, toDate: item.toDate,isChecked: item.isChecked, isFavorite: item.isFavorite))
            self.count += 1
        }
    }
    
    func sendNotification(id:Int){
        notificationCentent.title = self.ToDoList[id].title
        notificationCentent.sound = UNNotificationSound.default
        let tigger = UNTimeIntervalNotificationTrigger(timeInterval: self.ToDoList[id].toDate.timeIntervalSinceNow, repeats: false) //发送通知指定事件
        let request = UNNotificationRequest(identifier: self.ToDoList[id].title+self.ToDoList[id].toDate.description, content: notificationCentent, trigger: tigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    func withDrawNotification(id: Int){
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [self.ToDoList[id].title+self.ToDoList[id].toDate.description])
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [self.ToDoList[id].title+self.ToDoList[id].toDate.description])
    }
    
    func check(id: Int){
//        print(id)
        self.ToDoList[id].isChecked.toggle()
        self.dataStore()
    }
    
    func add(data: SingleToDu){
        print("\(data)")
        self.ToDoList.append(SingleToDu(id: self.count, title: data.title, toDate: data.toDate,isFavorite: data.isFavorite))
        self.count += 1
        self.sort()
        self.dataStore()
        self.sendNotification(id: self.ToDoList.count - 1)
    }
    func edit(id: Int, data: SingleToDu){
        self.withDrawNotification(id: id)
        self.ToDoList[id].title = data.title
        self.ToDoList[id].toDate = data.toDate
        self.ToDoList[id].isChecked = false
        self.ToDoList[id].isFavorite = data.isFavorite
        self.sort()
        self.dataStore()
        
        self.sendNotification(id: id)
    }
    func sort(){
        self.ToDoList.sort(by: {(data1,data2) in
            return data1.toDate.timeIntervalSince1970 < data2.toDate.timeIntervalSince1970
        })
        for i in 0..<self.ToDoList.count {
            self.ToDoList[i].id = i
        }
    }
    func delete(id: Int) {
        
        self.withDrawNotification(id: id)
        self.ToDoList[id].deleted = true
        self.dataStore()
    }
    
    func dataStore(){
        print(self.ToDoList)
        let dataStored = try! encoder.encode(self.ToDoList)
        UserDefaults.standard.set(dataStored, forKey: "ToDoList")
    }
}

struct SingleToDu: Identifiable ,Codable{
    var id: Int = 0
    var title: String = ""
    var toDate: Date = Date()
    var isChecked: Bool = false
    var deleted: Bool = false
    var isFavorite: Bool = false
}



