class Song{
  final String title;
  final String description;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    required this.description,
    required this.url,
    required this.coverUrl,
});


  static List<Song> songs = [
    Song(
      title: 'Bekheyali',
      description: 'Bekheyali',
      url: 'assets/music/Bekhayali-Arijit_Singh_Version-Kabir_Singh_FusionBD.Com.mp3',
      coverUrl:'assets/images/i1.jpg'
    ),
    Song(
        title: 'Tujhe Kitna',
        description: 'Tujhe Kitna',
        url: 'assets/music/Tujhe_Kitna_Chahein_Aur-Film_Version-Kabir_Singh_FusionBD.Com.mp3',
        coverUrl:'assets/images/i2.jpg'
    ),
    Song(
        title: 'Maluma',
        description: 'Maluma',
        url: 'assets/music/Kaise_Hua-Kabir_Singh_FusionBD.Com.mp3',
        coverUrl:'assets/images/i3.jpg'
    ),
    Song(
        title: 'La la la',
        description: 'Hips Dont Lie',
        url: 'assets/music/Tera_Ban_Jaunga-Kabir_Singh_FusionBD.Com.mp3',
        coverUrl:'assets/images/i4.jpg'
    ),
  ];
}