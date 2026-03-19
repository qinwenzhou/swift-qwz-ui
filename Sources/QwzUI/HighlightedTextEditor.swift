//
//  HighlightedTextEditor.swift
//  swift-qwz-ui
//
//  Created by david on 2026/3/19.
//

import SwiftUI
import UIKit

public struct HighlightedTextEditor: UIViewRepresentable {
    @Binding public var text: String
    
    public var font: UIFont
    public var textColor: UIColor
    
    public var highlightedPattern: String
    public var highlightedFont: UIFont
    public var highlightedForegroundColor: UIColor
    public var highlightedBackgroundColor: UIColor
    
    public func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = self.font
        textView.textColor = self.textColor
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        return textView
    }
    
    public func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.font = self.font
        uiView.textColor = self.textColor
        
        // 防止由于状态更新导致的循环刷新和光标跳动
        if uiView.text != text {
            uiView.text = text
            applyHighlighting(to: uiView)
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // 核心高亮逻辑提取
    func applyHighlighting(to textView: UITextView) {
        // 1. 保存当前光标位置 (关键：否则每次重绘光标会跑到末尾)
        let selectedRange = textView.selectedRange
        
        let textContent = textView.text ?? ""
        let attributedString = NSMutableAttributedString(string: textContent)
        
        // 2. 设置全局的基础样式
        let fullRange = NSRange(location: 0, length: attributedString.length)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 16), range: fullRange)
        attributedString.addAttribute(.foregroundColor, value: UIColor.label, range: fullRange) // 适配暗黑模式的普通文本颜色
        
        // 3. 正则匹配并应用高亮样式
        let pattern = self.highlightedPattern
        if let regex = try? NSRegularExpression(pattern: pattern) {
            let matches = regex.matches(in: textContent, range: fullRange)
            for match in matches {
                attributedString.addAttribute(.font, value: self.highlightedFont, range: match.range)
                attributedString.addAttribute(.foregroundColor, value: self.highlightedForegroundColor, range: match.range)
                attributedString.addAttribute(.backgroundColor, value: self.highlightedBackgroundColor, range: match.range)
            }
        }
        
        // 4. 将富文本立刻应用回 UITextView
        textView.attributedText = attributedString
        
        // 5. 还原光标位置
        textView.selectedRange = selectedRange
    }
    
    // 代理类，用于监听输入事件并将数据同步回 SwiftUI
    public class Coordinator: NSObject, UITextViewDelegate {
        var parent: HighlightedTextEditor
        
        init(_ parent: HighlightedTextEditor) {
            self.parent = parent
        }
        
        public func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
            self.parent.applyHighlighting(to: textView)
        }
        
        public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // 条件判断：text 为空字符串，说明用户触发了“删除/退格”操作
            if text.isEmpty {
                let currentText = (textView.text ?? "") as NSString
                let pattern = self.parent.highlightedPattern
                
                guard let regex = try? NSRegularExpression(pattern: pattern) else { return true }
                
                // 获取当前所有的变量 Range
                let fullRange = NSRange(location: 0, length: currentText.length)
                let matches = regex.matches(in: currentText as String, range: fullRange)
                
                // 设定将要删除的范围（初始为用户按退格键产生的一格或多格选中区域）
                var deleteRange = range
                var shouldManualDelete = false
                
                for match in matches {
                    // 判断：如果用户的删除范围和变量范围有重叠 (交集长度 > 0)
                    if NSIntersectionRange(deleteRange, match.range).length > 0 {
                        // 吸附效果：将删除范围扩大，合并整个变量的范围
                        deleteRange = NSUnionRange(deleteRange, match.range)
                        shouldManualDelete = true
                    }
                }
                
                // 如果确认触碰到了变量，我们需要接管删除动作
                if shouldManualDelete {
                    // 1. 算出删掉变量后的新字符串
                    let newText = currentText.replacingCharacters(in: deleteRange, with: "")
                    
                    // 2. 赋值给 textView
                    textView.text = newText
                    
                    // 3. 把光标放到原来变量开始的地方
                    textView.selectedRange = NSRange(location: deleteRange.location, length: 0)
                    
                    // 4. 手动触发一下高亮和 SwiftUI 的 Binding 更新
                    self.textViewDidChange(textView)
                    
                    // 5. 返回 false 告诉系统：我已经处理了，你不需要再执行默认的逐字删除
                    return false
                }
            }
            
            // 正常输入或其他情况，走系统默认逻辑
            return true
        }
    }
}
