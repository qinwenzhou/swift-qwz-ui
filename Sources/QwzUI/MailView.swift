//
//  MailView.swift
//  iPrompt
//
//  Created by qinwenzhou on 2026/1/31.
//

import SwiftUI
import MessageUI

public struct MailView: UIViewControllerRepresentable {
    public var recipients: [String]
    public var subject: String
    public var messageBody: String
    @Binding public var isShowing: Bool
    @Binding public var result: Result<MFMailComposeResult, Error>?
    
    public init(
        recipients: [String] = [],
        subject: String = "",
        messageBody: String = "",
        isShowing: Binding<Bool>,
        result: Binding<Result<MFMailComposeResult, Error>?>
    ) {
        self.recipients = recipients
        self.subject = subject
        self.messageBody = messageBody
        self._isShowing = isShowing
        self._result = result
    }
    
    public class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding public var isShowing: Bool
        @Binding public var result: Result<MFMailComposeResult, Error>?
        
        public init(isShowing: Binding<Bool>, result: Binding<Result<MFMailComposeResult, Error>?>) {
            _isShowing = isShowing
            _result = result
        }
        
        public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }
            if let error = error {
                self.result = .failure(error)
            } else {
                self.result = .success(result)
            }
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(isShowing: $isShowing, result: $result)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.mailComposeDelegate = context.coordinator
        vc.setToRecipients(recipients)
        vc.setSubject(subject)
        vc.setMessageBody(messageBody, isHTML: false)
        return vc
    }
    
    public func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {
        // Don't need to update
    }
}
