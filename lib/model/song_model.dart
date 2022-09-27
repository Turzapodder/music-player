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
      title: 'Kya Mujhe Pyaar Hain',
      description: 'Hindi-Mix Lofi Songs',
      url: 'assets/music/hindi.mp3',
      coverUrl:'assets/images/i-1.png'
    ),
    Song(
        title: 'BTS- Black Swan',
        description: 'K-POP Music',
        url: 'assets/music/bts.mp3',
        coverUrl:'assets/images/i2.jpg'
    ),
    Song(
        title: 'Enrique Iglesis- Bailando',
        description: 'Latin Pop Music',
        url: 'assets/music/maluma.mp3',
        coverUrl:'assets/images/i3.jpg'
    ),
    Song(
        title: 'Shakira- Loca Loca',
        description: 'Spanish Artists',
        url: 'assets/music/shakira.mp3',
        coverUrl:'assets/images/i4.jpg'
    ),
    Song(
        title: 'Nucleya- Bass Rani',
        description: 'Electric Dubstep MIx',
        url: 'assets/music/nucleya.mp3',
        coverUrl:'assets/images/i-4.png'
    ),
    Song(
        title: 'Farooq- Rup Suhana Lagta Hain',
        description: 'Bollywood Remixes',
        url: 'assets/music/Roop.mp3',
        coverUrl:'assets/images/i-5.png'
    ),
  ];
}