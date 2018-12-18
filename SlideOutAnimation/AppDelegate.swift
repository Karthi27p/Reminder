//
//  AppDelegate.swift
//  SlideOutAnimation
//
//  Created by Karthi on 04/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import GoogleMobileAds
import Fabric
import Crashlytics
import MessageUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MFMailComposeViewControllerDelegate {
    
    var window: UIWindow?
    var id = 0
    var remaindLater = false
    var emailReminder = false
    let vc = ViewController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GADMobileAds.configure(withApplicationID: "ca-app-pub-3940256099942544~1458002511")
        Fabric.with([Crashlytics.self])
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        let action = UNNotificationAction(identifier: "remindTomorrow", title: "Remind Me Tomorrow", options: [])
        let getinAction = UNNotificationAction(identifier: "getIn", title: "Get In", options:UNNotificationActionOptions.foreground)
        let textAction = UNTextInputNotificationAction(identifier: "TextInput", title: "Remind Me After Few Minutes", options:[], textInputButtonTitle: "Send", textInputPlaceholder: "Enter the minutes to remind later in number")
        let category = UNNotificationCategory(identifier: "myCategory", actions: [action,getinAction,textAction], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "SlideOutAnimation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func scheduleNotification(at date: Date, event: String, repeatValue: Bool) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: repeatValue)
        
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        if(remaindLater == false)
        {
            content.body = "You have a remainder for "+event
        }
        else
        {
            content.title = "Updated Reminder"
            content.body = "You have a remainder for"+event
            remaindLater = false
        }
        content.sound = UNNotificationSound.default
        if let path = Bundle.main.path(forResource: "reminder", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "image", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        content.categoryIdentifier = "myCategory"
        let request = UNNotificationRequest(identifier: event, content: content, trigger: trigger)
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
            
        }
    }
    
    //Schedule email reminders
    func scheduledBirthdayEmails(at date: Date, subject: String, to: String, body: String) {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        let newComponents = DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: newComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = subject
        content.body = body
        content.subtitle = to
        content.sound = UNNotificationSound.default
        if let path = Bundle.main.path(forResource: "reminder", ofType: "png") {
            let url = URL(fileURLWithPath: path)
            
            do {
                let attachment = try UNNotificationAttachment(identifier: "image", url: url, options: nil)
                content.attachments = [attachment]
            } catch {
                print("The attachment was not loaded.")
            }
        }
        content.categoryIdentifier = "myCategory"
        let request = UNNotificationRequest(identifier: subject, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error in notification request \(error)")
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        id += 1
        let idString : String = String(id)
        let remaindLaterId : String = (" "+idString)
        if response.actionIdentifier == "remindTomorrow" {
            remaindLater = true
            let newDate = Date(timeInterval: (24*60), since: Date())
            scheduleNotification(at: newDate,event:remaindLaterId, repeatValue: false)
        }
        if response.actionIdentifier == "getIn" {
            if(self.emailReminder) {
                let emailVC = EmailReminderViewController()
                let mailComposeViewController = emailVC.configureMailComposer(mailId: [response.notification.request.content.subtitle] , subject: response.notification.request.content.title, body: response.notification.request.content.body)
                mailComposeViewController.mailComposeDelegate = self
                if MFMailComposeViewController.canSendMail(){
                    if((window?.rootViewController?.presentedViewController) != nil) {
                        window?.rootViewController?.presentedViewController?.dismiss(animated: true, completion: {
                            let navVC = self.window?.rootViewController as? UINavigationController
                            navVC?.visibleViewController?.present(mailComposeViewController, animated: true, completion: nil)
                        }
                        )
                    } else {
                        window?.rootViewController?.present(mailComposeViewController, animated: true, completion: nil)
                    }
                } else{
                    print("Can't send email")
                }
            }else {
                
            }
        }
        if response.actionIdentifier == "TextInput"
        {
            if let textResponse = response as? UNTextInputNotificationResponse {
                let reply = textResponse.userText
                let num : Int?
                num = Int(reply)
                // Send reply message
                if(num == nil)
                {
                    let alert = UIAlertController(title: "Sorry! Your Input Was Not Recorded!", message: "Please Enter Minutes in Number", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                    window?.rootViewController?.present(alert, animated: true, completion: nil)
                    return
                }
                let minutes = Double(reply)
                print(reply)
                remaindLater = true
                let newDate = Date(timeInterval: (minutes!*60) , since: Date())
                scheduleNotification(at: newDate,event:remaindLaterId, repeatValue: false)
            }
        }
        
        
    }

    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNTextInputNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "TextInput"
        {
            let enteredText = response.userText
            print(enteredText)
        }
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .sound])
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if (shortcutItem.type == "com.tringapps.slideoutanimation.add")
        {
            
            let addVC: AddEventsViewController = storyboard.instantiateViewController(withIdentifier: "AddEvents") as! AddEventsViewController
            
            let rootViewController = self.window!.rootViewController as! UINavigationController
            rootViewController.pushViewController(addVC, animated: true)
        }
        
        if (shortcutItem.type == "com.tringapps.slideoutanimation.scheduled")
        {
            let eventsVC : DayEventsViewController = storyboard.instantiateViewController(withIdentifier: "ScheduledEvents") as! DayEventsViewController
            let rootViewController = self.window!.rootViewController as! UINavigationController
            rootViewController.pushViewController(eventsVC, animated: true)
        }
        
        if(shortcutItem.type == "com.tringapps.slideoutanimation.emaiReminders")
        {
            let emailReminderVC : EmailReminderViewController = storyboard.instantiateViewController(withIdentifier: "Email") as! EmailReminderViewController
            let rootViewController = self.window!.rootViewController as! UINavigationController;
            rootViewController.pushViewController(emailReminderVC, animated: true);
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail Cancelled")
            break
        case .saved :
            print("Mail Saved")
            break
        case .failed:
            print("Mail failed")
            break
        case .sent:
            print("Mail sent")
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
}

