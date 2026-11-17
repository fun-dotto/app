/// 設定画面で選択できるユーザー情報の項目。
enum UserProfileField {
  grade('学年'),
  course('コース'),
  academicClass('クラス');

  new(this.title);

  final String title;
}
