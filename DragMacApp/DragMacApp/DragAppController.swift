//
//  DragAppController.swift
//  DragMacApp
//
//  Created by 韩承海 on 2018/2/1.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import Cocoa

//支持拖拽
class DragAppController: NSObject, NSWindowDelegate, NSDraggingDestination{
    
    @IBOutlet weak var dragMenu: NSMenu!
    let dragStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    override func awakeFromNib() {
        dragStatusItem.title = "黑豆"
        dragStatusItem.menu = dragMenu
        
        dragStatusItem.button?.window?.registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
        dragStatusItem.button?.window?.delegate = self
        
    }
    
    func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        return NSDragOperation.copy
    }
    

    //https://ssflight.blogspot.com/2017/10/swift-4.html
    func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let filePaths = sender.draggingPasteboard().propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? [String]
        let uploadManager = DragUploadManager.share
        uploadManager.uploadFiles(filePaths: filePaths!)
        return true
    }
    
    @IBAction func quitAction(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    
    
    
    
}
