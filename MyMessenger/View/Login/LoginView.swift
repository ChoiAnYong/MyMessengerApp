//
//  LoginView.swift
//  MyMessenger
//
//  Created by 최안용 on 3/11/24.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var authViewModel: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("로그인")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.bkText)
                    .padding(.top, 30)
                    .padding(.bottom, 18)
                Text("아래 제공되는 서비스로 로그인을 해주세요.")
                    .font(.system(size: 14))
                    .foregroundColor(.greyDeep)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            Button(action: {}, label: {
                Text("Apple로 로그인")
            })
            .buttonStyle(LoginBtnStyle(textColor: .bkText, borderColor: .greyLight))
            
            Button(action: {
                authViewModel.send(action: .googleLogin)
            }, label: {
                Text("Google로 로그인")
            })
            .buttonStyle(LoginBtnStyle(textColor: .bkText, borderColor: .greyLight))
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Image("back")
                })
            }
        }
    }
}

#Preview {
    LoginView()
}
