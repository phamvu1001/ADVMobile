# jarvis

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Navigation.dart
File này định nghĩa giao diện chính cho ứng dụng sau khi đăng nhập:
- App bar
- Body: đây là các page được định nghĩa trong từng folder cụ thể của page.
- Các trang nằm trong menu tab cần được lưu lại trạng thái, tham khảo homPage.dart
- Muốn thêm tab mới cho page: thêm icons, labels, titles, pages trong stateclass _MyNavigationMenu
### Routes.dart
File này định nghĩa các trang con của 1 trang chính (ví dụ trang chat có nhiều thread, bấm vào 1 thread sẽ qua trang con)
- Routes chỉ được dùng cho các trang con
- Đối với trang con cần định nghĩa lại appBar.
- Hãy dùng Navigator.pushNamed(context, Routes.pathname) để navigate tới trang con.
- Thêm route path ở Routes.dart.
- Định nghĩa destination child-page trong main.dart.
