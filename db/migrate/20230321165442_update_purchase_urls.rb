class UpdatePurchaseUrls < ActiveRecord::Migration[6.1]
  def up
    iu = {
      30 =>	"https://iupress.org/9780253022295/abidjan-usa/",
      33 =>	"https://iupress.org/9780253018335/greek-orthodox-music-in-ottoman-istanbul/",
      27 => "https://iupress.org/9780253007292/highlife-saturday-night/",
      31 =>	"https://iupress.org/9780253012043/hip-hop-ukraine/",
      2 => "https://iupress.org/9780253222923/live-from-dar-es-salaam/",
      36 =>	"https://iupress.org/9780253017611/music-and-the-armenian-diaspora/",
      22 =>	"https://iupress.org/9780253006684/music-in-kenyan-christianity/",
      38 =>	"https://iupress.org/9780253019455/music-of-azerbaijan/",
      32 =>	"https://iupress.org/9780253015570/new-york-noise/",
      40 =>	"https://iupress.org/9780253021458/spiders-of-the-market/",
      39 =>	"https://iupress.org/9780253017420/staging-ghana/",
      5 => "https://iupress.org/9780253056771/tamil-folk-music-as-dalit-liberation-theology/",
      21 =>	"https://iupress.org/9780253219848/a-bird-dance-near-saturday-city/",
      41 =>	"https://iupress.org/9780253018038/african-music-power-and-being-in-colonial-zimbabwe/",
      14 =>	"https://iupress.org/9780253217189/arrest-the-music/",
      11 =>	"https://iupress.org/9780253216120/dan-ge-performance/",
      12 =>	"https://iupress.org/9780253219299/fiddling-in-west-africa/",
      19 =>	"https://iupress.org/9780253214362/ghanas-concert-party-theatre/",
      18 =>	"https://iupress.org/9780253108937/griots-at-war/",
      4 => "https://iupress.org/9780253222718/idolized/",
      17 =>	"https://iupress.org/9780253222930/learning-teaching-and-musical-identity/",
      15 =>	"https://iupress.org/9780253343376/son-jara/",
      26 =>	"https://iupress.org/9780253223371/tambu/",
      20 =>	"https://iupress.org/9780253216175/the-generation-of-plays/",
      13 =>	"https://iupress.org/9780253223135/the-politics-of-dress-in-somali-culture/"
    }
    temple = {
      3 => "https://tupress.temple.edu/books/sonic-spaces-of-the-karoo",
      6 => "https://tupress.temple.edu/books/the-dance-of-politics",
      7 => "https://tupress.temple.edu/books/sounding-off",
      8 => "https://tupress.temple.edu/books/masters-of-the-sabar",
      9 => "https://tupress.temple.edu/books/musica-nortena",
      24 => "https://tupress.temple.edu/books/fela",
      25 => "https://tupress.temple.edu/books/whose-national-music",
      35 => "https://tupress.temple.edu/books/music-and-social-change-in-south-africa"
    }
    iu.keys.each do |id|
      Book.find(id).update!(buy_url: iu[id])
    end
    temple.keys.each do |id|
      Book.find(id).update!(buy_url: temple[id])
    end
  end

  def down
    # nothing to do
  end
end
