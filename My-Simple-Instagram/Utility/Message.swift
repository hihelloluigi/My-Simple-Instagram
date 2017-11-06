//
//  Message.swift
//  My-Simple-Instagram
//
//  Created by Luigi Aiello on 06/11/17.
//  Copyright © 2017 Luigi Aiello. All rights reserved.
//

import Foundation
import SwiftMessages

class Message {
    /**
     Shows a "toast" message with a certain title and message.
     
        - parameter body: the message of the toast
        - parameter title: the title of the toast
        - parameter theme: the theme of the toast (info, warning, ...)
        - parameter layout: the UI of the toast (tab, card, ...)
     */
    class func show(message body: String, withTitle title: String, theme: Theme = .info, layout: MessageView.Layout = .messageView) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(theme)
        view.configureContent(title: title, body: body)
        view.button?.isHidden = true
        
        SwiftMessages.show(view: view)
    }
    /**
     Shows an success "toast" message with a certain message.
     
        - parameter body: the message of the toast
        - parameter layout: the UI of the toast (tab, card, ...)
     */
    class func show(success body: String, layout: MessageView.Layout = .messageView) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(.success)
        view.configureContent(title: "Common" ~> "success", body: body)
        view.button?.isHidden = true
        
        SwiftMessages.show(view: view)
    }
    
    /**
     Shows an error "toast" message with a certain message.
     
        - parameter body: the message of the toast
        - parameter layout: the UI of the toast (tab, card, ...)
     */
    class func show(error body: String, layout: MessageView.Layout = .messageView) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(.error)
        view.configureContent(title: "Common" ~> "error", body: body)
        view.button?.isHidden = true
        
        SwiftMessages.show(view: view)
    }
    /**
     Shows an info "toast" message with a certain message.
     
        - parameter body: the message of the toast
        - parameter layout: the UI of the toast (tab, card, ...)
     */
    class func show(info body: String, layout: MessageView.Layout = .messageView) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(.info)
        view.configureContent(title: "Common" ~> "info", body: body)
        view.button?.isHidden = true
        
        SwiftMessages.show(view: view)
    }
    /**
     Shows an `Error` instance leveraging the SwiftMessages library.
     
        - parameter error: the error that should be presented to the user
     */
    class func show(error: Error) {
        self.show(message: error.localizedDescription, withTitle: "[APP ERROR]", theme: .error)
    }
    /**
     Shows an warning "toast" message with a certain message.
     
        - parameter body: the message of the toast
        - parameter layout: the UI of the toast (tab, card, ...)
     */
    class func show(warning body: String, layout: MessageView.Layout = .messageView) {
        let view = MessageView.viewFromNib(layout: layout)
        view.configureTheme(.warning)
        view.configureContent(title: "Common" ~> "error", body: body)
        view.button?.isHidden = true
        
        SwiftMessages.show(view: view)
    }
}
