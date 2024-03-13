//
//  HomeView.swift
//  MyMessenger
//
//  Created by 최안용 on 3/13/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ProfileView(viewModel: viewModel)
                    .padding(.top, 24)
                    .padding(.bottom, 30)
                
                SearBtnView()
                    .padding(.bottom, 23)
                
                HStack {
                    Text("친구")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.bkText)
                    
                    Spacer()
                }
                .padding(.horizontal, 30)
                
                if viewModel.users.isEmpty {
                    Spacer(minLength: 89)
                    BeginningView()
                } else {
                    ForEach(viewModel.users, id: \.id) { user in
                        HStack(spacing: 8) {
                            Image("person")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                            
                            Text(user.name)
                                .font(.system(size: 12))
                                .foregroundColor(.bkText)
                            Spacer()
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
            .toolbar {
                Image("bookmark")
                Image("notifications")
                Image("person_add")
                Button(action: {
                    
                }, label: {
                    Image("settings")
                })
            }
        }
        .onAppear {
            viewModel.send(action: .getUser)
        }
    }
}

fileprivate struct ProfileView: View {
    @ObservedObject private var viewModel: HomeViewModel
    
    fileprivate init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment:.leading, spacing: 7) {
                Text(viewModel.myUser?.name ?? "이름")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.bkText)
                
                Text(viewModel.myUser?.description ?? "상태 메시지 입력")
                    .font(.system(size: 12))
                    .foregroundColor(.greyDeep)
            }
            
            Spacer()
            
            Image("person")
                .resizable()
                .frame(width: 42, height: 42)
                .clipShape(Circle())
        }
        .padding(.horizontal, 30)
    }
}

fileprivate struct SearBtnView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 36)
                .background(Color.greyCool)
                .cornerRadius(5)
            HStack {
                Text("검색")
                    .font(.system(size: 12))
                    .foregroundColor(.greyLightVer2)
                
                Spacer()
            }
            .padding(.leading, 22)
        }
        .padding(.horizontal, 30)
    }
}

fileprivate struct BeginningView: View {
    var body: some View {
        VStack {
            VStack(spacing: 3) {
                Text("친구를 추가해보세요.")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.bkText)
                Text("큐알코드나 검색을 이용해서 친구를 추가해보세요.")
                    .font(.system(size: 14))
                    .foregroundColor(.greyDeep)
            }
            .padding(.bottom, 30)
            
            Button(action: {
                
            }, label: {
                Text("친구추가")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.bkText)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 9)
            })
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.greyLight)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: .init(container: .init(services: StubService()), userId: "user1_id"))
}
