//
//  ContentView.swift
//  calculator
//
//  Created by MacBook Air on 02/05/24.
//

import SwiftUI

enum CalcButton: String{
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "/"
    case multiple = "*"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color{
        switch self{
        case .add, .substract, .multiple, .divide , .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red:55/255.0,green: 55/255.0, blue: 55/255.0,alpha: 1))
        }
    }
}

enum operation{
    case add, substract, multiple, divide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiple],
        [.four, .five, .six, .substract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    
    var body: some View {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack{
                    Spacer()
//                    text display
                    HStack{
                        Spacer()
                        Text(value)
                            .bold()
                            .font(.system(size: 100))
                            .foregroundStyle(.white)
                    }
                    .padding()
                    
                    ForEach(buttons, id: \.self){ row in
                        HStack{
                            ForEach(row, id: \.self){item in
                                Button(action: {
                                    self.didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 32))
                                        .frame( 
                                            width: self.buttonWidth(item: item),
                                            height: self.buttonHeight())
                                        .background(item.buttonColor)
                                        .foregroundStyle(.white)
                                        .cornerRadius(self.buttonWidth(item: item)/2)
                                }
                            )}
                        }
                        .padding(.bottom, 3)
                    }
                        
                }
            }
    }
    
    func didTap(button: CalcButton){
        switch button{
        case .add, .substract, .multiple, .divide, .equal:
            if button == .add{
                self.currentOperation = .add
                self.runningNumber += Int(self.value) ?? 0
            }else if button == .substract{
                self.currentOperation = .substract
                self.runningNumber -= Int(self.value) ?? 0
            }else if button == .multiple{
                self.currentOperation = .multiple
                self.runningNumber *= Int(self.value) ?? 0
            }else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber /= Int(self.value) ?? 0
            }else if button == .equal{
                if runningNumber == 0{
                    self.runningNumber = 0
                }
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation{
                case .add: self.value = "\(runningValue + currentValue)"
                case .substract: self.value = "\(runningValue - currentValue)"
                case .multiple: self.value = "\(runningValue * currentValue)"
                case .divide: self.value = "\(runningValue / currentValue)"
                case.none:
                    break
                }
            }
            
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value = "0"
            self.runningNumber = 0 // Reset runningNumber to 0
        case .decimal, .negative, .percent:
            break
        default :
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item:  CalcButton) -> CGFloat{
        if item == .zero{
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat{
        return(UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
