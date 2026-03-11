# 营业厅手机展示云平台 (Yingyeting Mobile Phone Display Cloud Platform)

[English](#english) | [中文](#中文)

---

## English

### Project Overview

This is a comprehensive telecom business hall management system that provides a mobile phone display and management platform for retail stores. The system supports multiple telecom carriers (China Mobile, China Unicom, China Telecom) and consists of Android apps, iOS app, web application, and web services.

### Architecture

```
dmy-business-hall/
├── Android/                # Android applications for different carriers
│   ├── YiDong/             # China Mobile (中国移动)
│   ├── LianTong/           # China Unicom (中国联通)
│   ├── DianXin/            # China Telecom (中国电信)
│   ├── YiDongPerson/       # China Mobile Staff Version
│   ├── LianTongPerson/     # China Unicom Staff Version
│   └── DianXinPerson/      # China Telecom Staff Version
├── iOS/                    # iOS application
│   └── YiDong/             # China Mobile iOS app
├── WebSite/                # ASP.NET MVC Web Application
│   └── YingytSite/         # Main web portal
├── WebService/             # WCF Web Services
│   └── YYTService/         # Backend API services
└── Document/               # Documentation and resources
    ├── Image/              # QR code images
    └── Develop/            # Development plans and test cases
```

### Technology Stack

| Component | Technology |
|-----------|------------|
| Backend | ASP.NET MVC 5, WCF, C# |
| Database | SQL Server |
| Android | Java, minSdkVersion 11, targetSdkVersion 16 |
| iOS | Objective-C |
| Networking | AFNetworking (iOS) |
| Keyboard | IQKeyboardManager (iOS) |

### Features

#### Mobile Applications
- **Phone Display**: Browse mobile phone catalog with detailed specifications
- **Feature Comparison**: Compare phones by brand or category
- **Video Playback**: Watch product videos
- **Image Gallery**: View detailed product photos
- **Statistics**: Track usage and popular items
- **Courtesy Service**: Customer service features

#### Web Portal
- Hall management
- Region management
- User/Agent administration
- System configuration
- Media upload (images, videos)
- Account management

### Database

- **Main Database**: `yingyeting.mdf`
- **Log Database**: `yingyeting_log.ldf`
- **Connection**: Configured in `WebSite/YingytSite/ConnStrings.config`

### Android App Activities

| Activity | Description |
|----------|-------------|
| MainActivity | Main entry point |
| SplashActivity | Splash screen |
| MainMenuActivity | Main menu navigation |
| FeatureActivity | Phone features display |
| CompareBrandActivity | Brand comparison |
| CompareKindActivity | Category comparison |
| StatisticsActivity | Usage statistics |
| CourtesyActivity | Customer courtesy service |
| VideoPlayActivity | Video playback |
| DetailPhotoActivity | Photo detail view |
| ImgListActivity | Image gallery |

### Building & Deployment

#### Prerequisites
- Visual Studio 2015+ (for .NET projects)
- Android SDK (for Android apps)
- Xcode (for iOS app)
- SQL Server 2012+

#### Web Application
1. Open `WebSite/YingytSite/YingytSite.sln` in Visual Studio
2. Update connection string in `ConnStrings.config`
3. Build and deploy to IIS

#### Web Services
1. Open `WebService/YYTService/YYTService.sln`
2. Update connection string in `YYTService/YYTService/ConnStrings.config`
3. Build and deploy to IIS

#### Android
1. Import projects from `Android/*/` directories into Android Studio/Eclipse
2. Build debug or release APK

#### iOS
1. Open `iOS/YiDong/YiDong.xcodeproj` in Xcode
2. Build for simulator or device

### Project Structure

#### Controllers (Web)
- `AccountController` - Account management
- `AgtController` - Agent management
- `HallController` - Business hall management
- `HomeController` - Home page
- `RegionController` - Region management
- `SystemController` - System configuration
- `UploadController` - File uploads
- `UserController` - User management

#### Models
- AgentModel, HallModel, HomeModel, ImageModel, MarketModel, PhoneModel, RegionModel, SystemModel, TemplateModel, UserModel, VideoModel

### License

This project is for internal business use.

---

## 中文

### 项目概述

这是一个综合性的电信营业厅管理系统，提供手机展示和管理平台。该系统支持多个电信运营商（中国移动、中国联通、中国电信），包括Android应用、iOS应用、Web应用程序和Web服务。

### 项目架构

```
dmy-business-hall/
├── Android/                # 不同运营商的Android应用
│   ├── YiDong/             # 中国移动
│   ├── LianTong/           # 中国联通
│   ├── DianXin/            # 中国电信
│   ├── YiDongPerson/       # 中国移动员工版
│   ├── LianTongPerson/     # 中国联通员工版
│   └── DianXinPerson/      # 中国电信员工版
├── iOS/                    # iOS应用
│   └── YiDong/             # 中国移动iOS版
├── WebSite/                # ASP.NET MVC Web应用程序
│   └── YingytSite/         # 门户网站
├── WebService/             # WCF Web服务
│   └── YYTService/         # 后端API服务
└── Document/               # 文档和资源
    ├── Image/              # 二维码图片
    └── Develop/            # 开发计划和测试用例
```

### 技术栈

| 组件 | 技术 |
|------|------|
| 后端 | ASP.NET MVC 5, WCF, C# |
| 数据库 | SQL Server |
| Android | Java, minSdkVersion 11, targetSdkVersion 16 |
| iOS | Objective-C |
| 网络库 | AFNetworking (iOS) |
| 键盘管理 | IQKeyboardManager (iOS) |

### 功能特点

#### 移动应用
- **手机展示**: 浏览手机目录和详细规格
- **功能对比**: 按品牌或类别对比手机
- **视频播放**: 观看产品视频
- **图片相册**: 查看产品详情图片
- **数据统计**: 跟踪使用情况和热门商品
- **礼貌服务**: 客户服务功能

#### Web门户
- 营业厅管理
- 区域管理
- 用户/代理商管理
- 系统配置
- 媒体上传（图片、视频）
- 账户管理

### 数据库

- **主数据库**: `yingyeting.mdf`
- **日志数据库**: `yingyeting_log.ldf`
- **连接配置**: 位于 `WebSite/YingytSite/ConnStrings.config`

### Android应用组件

| 组件 | 描述 |
|------|------|
| MainActivity | 主入口 |
| SplashActivity | 启动画面 |
| MainMenuActivity | 主菜单导航 |
| FeatureActivity | 手机功能展示 |
| CompareBrandActivity | 品牌对比 |
| CompareKindActivity | 类别对比 |
| StatisticsActivity | 使用统计 |
| CourtesyActivity | 客户服务 |
| VideoPlayActivity | 视频播放 |
| DetailPhotoActivity | 图片详情 |
| ImgListActivity | 图片相册 |

### 构建与部署

#### 前置条件
- Visual Studio 2015+ (用于.NET项目)
- Android SDK (用于Android应用)
- Xcode (用于iOS应用)
- SQL Server 2012+

#### Web应用程序
1. 在Visual Studio中打开 `WebSite/YingytSite/YingytSite.sln`
2. 更新 `ConnStrings.config` 中的连接字符串
3. 构建并部署到IIS

#### Web服务
1. 打开 `WebService/YYTService/YYTService.sln`
2. 更新 `YYTService/YYTService/ConnStrings.config` 中的连接字符串
3. 构建并部署到IIS

#### Android
1. 将 `Android/*/` 目录中的项目导入Android Studio/Eclipse
2. 构建debug或release APK

#### iOS
1. 在Xcode中打开 `iOS/YiDong/YiDong.xcodeproj`
2. 构建模拟器或设备版本

### 项目结构

#### Web控制器
- `AccountController` - 账户管理
- `AgtController` - 代理商管理
- `HallController` - 营业厅管理
- `HomeController` - 首页
- `RegionController` - 区域管理
- `SystemController` - 系统配置
- `UploadController` - 文件上传
- `UserController` - 用户管理

#### 数据模型
- AgentModel, HallModel, HomeModel, ImageModel, MarketModel, PhoneModel, RegionModel, SystemModel, TemplateModel, UserModel, VideoModel

### 许可证

本项目仅供内部业务使用。

